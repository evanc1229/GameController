import processing.serial.*;
Serial myPort;
int speed = 20;
int health = 100;
int score = 0;
int xSpeed = 2;
int ySpeed =3;
int xDirection = 1;
int yDirection = -1;
int window = 0;


HitBox paddleL = new HitBox(10,250, 5, 100);
HitBox paddleR = new HitBox(490, 250, 5, 100);
HitBox ball = new HitBox(200, 200, 50, 50);

void setup()
{
  size(500,500);
  ellipseMode(CORNER);
  myPort = new Serial(this, Serial.list()[1], 9600);
}

void draw()
{
  if(myPort.available() > 0)
  {
    String val = myPort.readStringUntil(':');
    if(window == 0){window++;}
    if(window == 1) 
    {
      if(val != null)
      {
        if(val.equals("UpB:"))
        {
          paddleL.y -= speed;
          if(paddleL.isColliding(ball) || paddleL.outOfBounds() || paddleR.isColliding(ball))
            while(paddleL.isColliding(ball) || paddleL.outOfBounds()){paddleL.y++;}
        }
        
        if(val.equals("DownB:"))
        {
          paddleL.y += speed;
          if(paddleL.isColliding(ball) || paddleL.outOfBounds() || paddleR.isColliding(ball))
            while(paddleL.isColliding(ball) || paddleL.outOfBounds()){paddleL.y--;}
        }
        
        if(val.startsWith("Pot"))
        {
          ball.w = Integer.parseInt(val.substring(3,val.length()-1));
          ball.h = Integer.parseInt(val.substring(3,val.length()-1));
        }
        
        }
        if(window == 2)
        {
          if(val.equals("HomeB:"))
             exit();
        }
      }
  }
    
  if(window == 0)
  {
    background(0,0,0);
    text("Press Any Key to Begin!", 180, 230);
  }
  
  if(window == 1) 
  {
    ball.x += xSpeed * xDirection;
    ball.y += ySpeed * yDirection;
    if(ball.x > 500 - ball.w || ball.x < 0)
    {
      ball.x = 200;
      ball.y = 200;
      xSpeed = 3;
      ySpeed = 2;
      xDirection *= -1;
      yDirection*= -1;
      health--;
      if(health == 0){window++;}
    }
    if(ball.y >500 - ball.h || ball.y < 0)
    {
      yDirection *= -1;
    }
    if(paddleL.isColliding(ball) || paddleR.isColliding(ball))
    {
     xDirection *= -1;
     score++;
    }
    background(255,255,255);
    stroke(0,0,0);
    text("Health: " + health, 5, 30);
    text("Score: " + score, 5, 15);
    fill(0,0,0);
    ellipse(ball.x, ball.y, ball.w, ball.h);
    rect(paddleL.x, paddleL.y, paddleL.w, paddleL.h);
    rect(paddleR.x, paddleR.y, paddleR.w, paddleR.h);
  }
  
  if(window == 2)
  {  
    background(255,255,255);
    text("GAME OVER!", 190, 230);
    text("Score: " + score , 190, 250);
    text("Press 'c' to close", 190, 270);
  }
}



void keyPressed()
{
  if(key == 'i')
      {
        paddleR.y -= speed;
        if(paddleL.isColliding(ball) || paddleR.outOfBounds() || paddleR.isColliding(ball))
          while(paddleR.isColliding(ball) || paddleR.outOfBounds()){paddleR.y++;}
      }
   if(key == 'k')
      {
        paddleR.y += speed;
        if(paddleL.isColliding(ball) || paddleR.outOfBounds() || paddleR.isColliding(ball))
          while(paddleR.isColliding(ball) || paddleR.outOfBounds()){paddleR.y--;}
      }
}

class HitBox 
{
    public float x,y,w,h;
    
    HitBox(float x, float y, float w, float h)
    {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
    }
   
    public boolean isColliding(HitBox s)
    {
      return s.x < (this.x + this.w) && this.x < (s.x + s.w) && s.y < (this.y + this.h) && this.y < (s.y + s.h);
    }
    
    public boolean outOfBounds(){
      return this.y < 0 || this.x < 0 || (this.y + this.h) > 500 || (this.x + this.w) > 500;
    }
}
