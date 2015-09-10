int fadeTime = 0;
int textHeight = -50;

void gameOver(int state)
{
  pushStyle();
  textFont(splatter, 32);

  if (state == 1)
  {
    if (fadeTime <= 199)
    {
      ++fadeTime;
    }
    fill(0, fadeTime);
    rect(0, 0, width, height);

    if (fadeTime >= 200);
    {
      textSize(72);
      fill(255, 140, 0);

      if (textHeight > height/2)
      {
        textHeight = height/2;
        delay(1000);
        inicializar();
        imagesCached = true;
        fadeTime = 0;
        textHeight = -50;
      }
      text("PERDISTE", width/2 - 115, ++textHeight);
    }
  } else if (state == 2)
  {
    if (fadeTime <= 199)
    {
      ++fadeTime;
    }
    fill(0, fadeTime);
    rect(0, 0, width, height);

    if (fadeTime >= 200);
    {
      textSize(72);
      fill(255, 140, 0);

      if (textHeight > height/2)
      {
        textHeight = height/2;
        delay(1000);
        inicializar();
        imagesCached = true;
        fadeTime = 0;
        textHeight = -50;
      }
      text("GANASTE", width/2 - 115, ++textHeight);
    }
  }
  popStyle();
}