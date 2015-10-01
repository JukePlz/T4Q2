void debugMode()
{
  //println(key, keyCode);
    
  if (key == '8')
  {
   gameOver = 1; 
  } else if (key == '7')
  {
    gameOver = 2;
  }
  
  if (renderType == JAVA2D)
  {
    keyCodeOffset = 15;
  } else
  {
    keyCodeOffset = 0;
  }

  if (key == '0')
  {
    debugCamera = !debugCamera;
    socketDrag = null;
    
    if (debugCamera)
    {
      debugText = "Vista: Kinect";
    } else
    {
      debugText = "Vista: Juego";
    }
    textTimer = 120;
  }

  if (key == '3')
  {
    kinectDetection = !kinectDetection;
    
    if (kinectDetection)
    {
      debugText = "Deteccion: Kinect";
    } else
    {
      debugText = "Deteccion: Mouse";
    }
    textTimer = 120;
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

  if (key == '1')
  {
    debugColision = !debugColision;
    
    if (debugColision)
    {
      debugText = "Ver Colisiones: ON";
    } else
    {
      debugText = "Ver Colisiones: OFF";
    }
    textTimer = 120;
  } else if (key == '2')
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
  } else if (keyCode == 116 + keyCodeOffset)           // F5
  {
    lightSystem = 1;
    lightIntensity = 1;
    darkness = loadImage("data/luces/lowLight.png");
    debugText = "Intensidad Luz: Baja";
    textTimer = 120;
  } else if (keyCode == 117 + keyCodeOffset)           // F6
  {
    lightSystem = 1;
    lightIntensity = 2;
    darkness = loadImage("data/luces/midLight.png");
    debugText = "Intensidad Luz: Media";
    textTimer = 120;
  } else if (keyCode == 118 + keyCodeOffset)           // F7
  {
    lightSystem = 1;
    lightIntensity = 3;
    darkness = loadImage("data/luces/highLight.png");
    debugText = "Intensidad Luz: Alta";
    textTimer = 120;
  } else if (keyCode == 119 + keyCodeOffset)           // F8
  {
    lightSystem = 0;
    darkness = null;
    debugText = "Luz Desactivada";
    textTimer = 120;
  }
}

