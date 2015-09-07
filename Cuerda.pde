class Cuerda
{
  int posX;
  int posY;
  FBox[] cuerda;
  FDistanceJoint[] joint;

  Cuerda(int _posX, int _posY, Socket miSocket)
  {
    posX = _posX;
    posY = _posY;

    cuerda = new FBox[10];
    joint = new FDistanceJoint[9];

    for (int i = 0; i < cuerda.length; i++)
    {
      cuerda[i] = new FBox(10, 10);
      cuerda[i].setNoStroke();
      cuerda[i].setPosition(posX, posY + i * 10);
      if (i < 8)
      {
        cuerda[i].setName( "cuerda" + String.format("%02d", miSocket.getSocketWidth()) + String.format("%02d", miSocket.getSocketHeight()) );
      } 
      if (i == 0)
      {
        cuerda[i].setStatic(true);
      }
      cuerda[i].setSensor(true);
      cuerda[i].setRestitution(0.4);
      cuerda[i].setGroupIndex(-1);
      mundo.add(cuerda[i]);
    }

    for (int i = 0; i < joint.length; i++)
    {
      joint[i] = new FDistanceJoint(cuerda[i], cuerda[i+1]);
      joint[i].setNoStroke();
      joint[i].setNoFill();
      joint[i].setLength(1);
      joint[i].setAnchor1(0, 5);
      joint[i].setAnchor2(0, -5);
      //joint[i].setDamping(5);
      mundo.add(joint[i]);
    }
  }

  void dibujar()
  {
    pushStyle();
    imageMode(CENTER);
    for (int i = 0; i < cuerda.length; i++)
    {
      pushMatrix();
      translate(cuerda[i].getX(), cuerda[i].getY());
      rotate(cuerda[i].getRotation());
      image(sogaSegmento, 0, 0);
      popMatrix();
    }

    popStyle();
  }

  void destroy()
  {
    for (int i = 0; i < joint.length; i++)
    {
      mundo.remove(joint[i]);
      joint[i] = null;
    }

    for (int i = 0; i < cuerda.length; i++)
    {
      mundo.remove(cuerda[i]);
      cuerda[i] = null;
    }
  }
}