class Contador
{
  int min;
  int max;
  int delay;
  int numero;
  boolean incrementando;
  boolean firstRun;

  Contador(int _min, int _max, int _delay)
  {
    min = _min;
    max = _max;
    delay = _delay;
    numero = _min;
    incrementando = true;
    firstRun = true;
  }


  int step()
  {
    if (frameCount % delay == 0)
    {
      if ((numero == max || numero == min) && !firstRun)
      {
        incrementando = !incrementando;
      }

      if (incrementando)
      {
        ++numero;
      } else if (!incrementando)
      {
        --numero;
      }

      if (firstRun)
      {
        firstRun = false;
      }
    }
    return numero;
  }
}