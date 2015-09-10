void debugMode()
{
  if (keyCode == 97)                  // F1
  {
    debugColision = !debugColision;
    if (debugColision)
    {
      debugText = "Debug Colisiones: ON";
    } else
    {
      debugText = "Debug Colisiones: OFF";
    }
    textTimer = 120;
  } else if (keyCode == 98)           // F2
  {
    mappingHelper = !mappingHelper;
    if (mappingHelper)
    {
      debugText = "Mapping Helper: ON";
    } else
    {
      debugText = "Mapping Helper: OFF";
    }
    textTimer = 120;
  } else if (keyCode == 101)           // F5
  {
    lightSystem = 1;
    lightIntensity = 1;
    darkness = loadImage("data/luces/lowLight.png");
    debugText = "Intensidad Luz: Baja";
    textTimer = 120;
  } else if (keyCode == 102)           // F6
  {
    lightSystem = 1;
    lightIntensity = 2;
    darkness = loadImage("data/luces/midLight.png");
    debugText = "Intensidad Luz: Media";
    textTimer = 120;
  } else if (keyCode == 103)           // F7
  {
    lightSystem = 1;
    lightIntensity = 3;
    darkness = loadImage("data/luces/highLight.png");
    debugText = "Intensidad Luz: Alta";
    textTimer = 120;
  } else if (keyCode == 104)           // F8
  {
    lightSystem = 0;
    darkness = null;
    debugText = "Luz Desactivada";
    textTimer = 120;
  }
}