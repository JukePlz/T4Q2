class Piedras
{
  int posx;
  int posy;
  int radio;
  boolean cayendo = false;

  Piedras(int _posx, int _posy, int _radio)
  {
    posx = _posx;
    posy = _posy;
    radio = _radio;
  }

  void dibujar()
  {
    if ((cayendo) && frameCount % 50 == 0)
    {
      FCircle c = new FCircle(radio);
      c.setPosition(random(305, 705), posy);
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
        //rotate(radians(frameCount%360) * 2);
        rotate(objetoi.getRotation());
        image(roca[int(objetoi.getName().substring(4))], 0, 0);
        popMatrix();

        //ellipse(objetoi.getX(), objetoi.getY(), radio, radio);
        popStyle();
      }
    }
  }
}