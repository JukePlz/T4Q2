import fisica.*;

void setup()
{
  size(600, 600);
}

void draw()
{
  // Test comment
  background(0);
  noStroke();
  fill(255, 0, 0);
  ellipseMode(CENTER);
  ellipse(width/2, height/2, 100, 100);
  fill(255);
  ellipse(width/2, height/2, 10, 10);
  println("Hello Dave...");
  noLoop();
  // Other comment

  newFunction();
}

void newFunction()
{
  println("something!");
}