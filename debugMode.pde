void debugMode()
{
  if (renderType == JAVA2D)
  {
    keyCodeOffset = 15;
  } else
  {
    keyCodeOffset = 0;
  }

  if (key == '+' || key == '-')
  {
    if (key == '+' && diametroSocket < 80)
    {
      ++diametroSocket;
      println("Diametro sockets: " + diametroSocket);
    } else if (key == '-' && diametroSocket > 1)
    {
      --diametroSocket;
      println("Diametro sockets: " + diametroSocket);
    }

    for (int i = 0; i < maSockets.length; i++)
    {
      for (int a = 0; a < maSockets[0].length; a++)
      {
        maSockets[i][a].grosor = diametroSocket;
      }
    }
  }

  if (keyCode == 97 + keyCodeOffset)                  // F1
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
  } else if (keyCode == 98 + keyCodeOffset)           // F2
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
  } else if (keyCode == 101 + keyCodeOffset)           // F5
  {
    lightSystem = 1;
    lightIntensity = 1;
    darkness = loadImage("data/luces/lowLight.png");
    debugText = "Intensidad Luz: Baja";
    textTimer = 120;
  } else if (keyCode == 102 + keyCodeOffset)           // F6
  {
    lightSystem = 1;
    lightIntensity = 2;
    darkness = loadImage("data/luces/midLight.png");
    debugText = "Intensidad Luz: Media";
    textTimer = 120;
  } else if (keyCode == 103 + keyCodeOffset)           // F7
  {
    lightSystem = 1;
    lightIntensity = 3;
    darkness = loadImage("data/luces/highLight.png");
    debugText = "Intensidad Luz: Alta";
    textTimer = 120;
  } else if (keyCode == 104 + keyCodeOffset)           // F8
  {
    lightSystem = 0;
    darkness = null;
    debugText = "Luz Desactivada";
    textTimer = 120;
  }
}