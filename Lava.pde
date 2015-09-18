class Lava
{
  int altoImagenLava;
  int alturaLava;
  int sway;
  boolean swayDirection;
  boolean erupcionando = false;

  Lava()
  {
    alturaLava = 0;
  }

  void dibujar()
  {
    if (frameCount % 5 == 0)
    {
      if (alturaLava> -800)
      {
        subir();
      }
    }

    if (swayDirection && frameCount % 5 == 0)
    {
      ++sway;
      if (sway > 35)
      {
        swayDirection = !swayDirection;
      }
    } else if  (!swayDirection && frameCount % 5 == 0)
    {
      --sway;
      if (sway <= 0)
      {
        swayDirection = !swayDirection;
      }
    }

    pushStyle();
    imageMode(CENTER);
    image(lava, width/2 + sway, alturaLava + 1200);
    popStyle();
  }

  void subir()
  {
    if (erupcionando)
    {
      --alturaLava;
    }
  }
}
