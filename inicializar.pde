void inicializar()
{
  imagesCached = false;
  mouseApretado = false;
  cantActivos = 0;
  ordenSogas = 0;
  textTimer = 0;
  gameOver = 0;
  vida = 3;
  timer = 0;
  timer2 = 0;
  debugText = null;

  if (lightSystem == 1)
  {
    if (lightIntensity == 1)
    {
      darkness = loadImage("data/luces/lowLight.png");
    } else if (lightIntensity == 2)
    {
      darkness = loadImage("data/luces/midLight.png");
    } else if (lightIntensity == 3)
    {
      darkness = loadImage("data/luces/highLight.png");
    }
  }

  mundo = new FWorld();  // CREA EL MUNDO PARA LA LIBRERIA DE FISICA
  mundo.clear();
  maSockets = new Socket[8][10];
  socketDrag = null;
  magma = new Lava();
  piedra = new Piedra(250, 25, 50);  // Constructor (POSX, POSY, RADIO)
  roberto = new Personaje(int(random(width/4, width*3/4)), height-32); // Constructor (POSX, POSY)

  // Vibracion de la luz, solo LightSystem = 2
  contadorLights = new Contador(1, 50, 2, 1);   // Constructor (MIN, MAX, DELAY, INCREMENTO)

  // Glow de las rajaduras en la pared
  contadorCracksPared = new Contador(30, 150, 1, 2);  // Constructor (MIN, MAX, DELAY, INCREMENTO)

  // Glow de las rajaduras en la pared
  contadorCracksRocas = new Contador(30, 150, 1, 2);  // Constructor (MIN, MAX, DELAY, INCREMENTO)

  bordeIzq = new FLine(offset1, 0, offset2, 768);
  bordeDer = new FLine(offset4, 768, offset3, 0);
  bordeIzq.setStatic(true);
  bordeDer.setStatic(true);
  bordeIzq.setStroke(255);
  bordeDer.setStroke(255);
  mundo.add(bordeIzq);
  mundo.add(bordeDer);

  mundo.setGravity( 0, 1000 );
  mundo.setGrabbable(false);

  // MAPA DE SOCKETS
  int[][] socketMap = 
  {
    {
      0, 0, 0, 1, 2, 1, 0, 0, 0, 0
    }
    , 
    {
      0, 0, 1, 2, 1, 2, 1, 0, 0, 0
    }
    , 
    {
      0, 0, 2, 1, 2, 1, 2, 0, 0, 0
    }
    , 
    {
      0, 0, 1, 2, 1, 2, 2, 0, 0, 0
    }
    , 
    {
      0, 2, 2, 1, 2, 1, 1, 2, 0, 0
    }
    , 
    {
      0, 1, 2, 2, 1, 2, 2, 1, 0, 0
    }
    , 
    {
      0, 2, 1, 2, 2, 1, 1, 2, 0, 0
    }
    , 
    {
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    }
  };

  // SETEO DE SOCKETS
  for (int i = 0; i < maSockets.length; i++)
  {
    for (int a = 0; a < maSockets[0].length; a++)
    {
      if (socketMap[i][a] <= 1 )
      {
        maSockets[i][a] = new Socket(width/(maSockets[0].length -1) * a +56, height/(maSockets.length -1) * i +16, "oculto" ); // Constructor (POSX, POSY, ESTADO)
      } else if (socketMap[i][a] == 2 )
      {
        maSockets[i][a] = new Socket(width/(maSockets[0].length -1) * a +56, height/(maSockets.length -1) * i +16, "disponible" ); // Constructor (POSX, POSY, ESTADO)
      }
    }
  }

  File screenCap = new File("C:/screenCap.jpg");

  if (screenCap.exists())
  {
    capturaKinect = loadImage("C:/screenCap.jpg");
    capturaKinectTemp = capturaKinect;
  } else
  {
    println("No se encontro screenCap en C:/");
    println("kinectCap debe estar ejecutandose");
    println("kinectCap y este Sketch deben poder escribir en C:/");
    exit();
  }
}

