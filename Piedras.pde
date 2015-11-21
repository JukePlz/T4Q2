class Piedra
{
  int posX;
  int posY;
  int radio;
  boolean cayendo;

  Piedra(int _posX, int _posY, int _radio)
  {
    posX = _posX;
    posY = _posY;
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
      c.setDensity(200);
      c.setVelocity(random(-500, 500), 0);
      c.setRestitution(0.3);
      c.setAngularVelocity(radians(int(random(-360, 360))));
      mundo.add(c);
    }

    ArrayList<FBody> objetosMundo = mundo.getBodies();

    for (int i = 0; i < objetosMundo.size(); i++)
    {
      FBody objetoi = objetosMundo.get(i);

      if (objetoi.getName() != null && objetoi.getName().substring(0, min(objetoi.getName().length(), 4)).equals("roca"))
      {
        graph.pushStyle();
        graph.fill(color(#c87e4d));
        graph.noStroke();
        graph.imageMode(CENTER);

        if (lightSystem == 1)
        {
          graph.blendMode(ADD);
          graph.image(aura, objetoi.getX(), objetoi.getY());
          graph.blendMode(BLEND);
        }

        graph.pushMatrix();
        graph.translate(objetoi.getX(), objetoi.getY());
        graph.rotate(objetoi.getRotation());
        graph.image(roca[int(objetoi.getName().substring(min(objetoi.getName().length(), 4)))], 0, 0);
        graph.pushStyle();
        graph.tint(255, contadorCracksRocas.numero);
        graph.image(magmaRoca[int(objetoi.getName().substring(min(objetoi.getName().length(), 4)))], 0, 0);
        graph.popStyle();
        graph.popMatrix();
        graph.popStyle();
      }
    }
  }
}
