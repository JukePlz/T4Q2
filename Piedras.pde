class Piedras
{
  int posX;
  int posY;
  int radio;
  boolean cayendo;

  Piedras(int _posx, int _posy, int _radio)
  {
    posX = _posx;
    posY = _posy;
    radio = _radio;
    cayendo = false;
  }

  void dibujar()
  {
    if ((cayendo) && frameCount % 50 == 0)
    {
      FCircle c = new FCircle(radio);
      c.setPosition(random(305, 705), posY);
      c.setName( "roca" + int(random(0, 4)) );
      c.setVelocity(random(-500, 500), 0);
      c.setFillColor(color(#c87e4d));
      c.setNoStroke();
      c.setRestitution(0.4);
      c.setAngularVelocity(radians(int(random(-360, 360))));
      mundo.add(c);
    }
    ArrayList<FBody> objetosMundo = mundo.getBodies();
    for (int i = 0; i < objetosMundo.size(); i++)
    {
      FBody objetoi = objetosMundo.get(i);
      if (objetoi.getName() != null && objetoi.getName().substring(0, 4).equals("roca"))
      {
        pushStyle();
        fill(color(#c87e4d));
        noStroke();
        imageMode(CENTER);
        pushMatrix();
        translate(objetoi.getX(), objetoi.getY());
        rotate(objetoi.getRotation());
        image(roca[int(objetoi.getName().substring(4))], 0, 0);
        popMatrix();
        popStyle();
      }
    }
  }
}