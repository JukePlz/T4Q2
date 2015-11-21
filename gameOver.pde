int timer;
int timer2;

void gameOver(int state)
{
  graph.pushStyle();
  if (state == 1)
  {
    if (frameCount % 20 == 0)
    {
      ++timer;
      if (timer > 6)
      {
        delay(2000);
        inicializar();
        imagesCached = true;
      }
    }
    graph.image(perdiste[timer], 0, 0);
  } else if (state == 2)
  {
    if (frameCount % 15 == 0)
    {
      ++timer;
      if (timer2 > 2)
      {
        delay(2000);
        inicializar();
        imagesCached = true;
      }
      if (timer > 6)
      {
        timer = 3;
        ++timer2;
      }
    }
    graph.image(ganaste[timer], 0, 0);
  }
  graph.popStyle();
}
