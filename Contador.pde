class Contador
{
  int min;
  int max;
  int delay;
  int incremento;
  int numero;
  boolean incrementando;
  boolean firstRun;

  Contador(int _min, int _max, int _delay, int _incremento)
  {
    min = _min;
    max = _max;
    delay = _delay;
    incremento = _incremento;
    numero = _min;
    incrementando = true;
    firstRun = true;
  }


  int step()
  {
    if (frameCount % delay == 0)
    {
      if ((numero >= max || numero <= min) && !firstRun)
      {
        incrementando = !incrementando;
      }

      if (incrementando)
      {
        numero += incremento;
      } else if (!incrementando)
      {
        numero -= incremento;
      }

      if (firstRun)
      {
        firstRun = false;
      }
    }
    return numero;
  }
}
