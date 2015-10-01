void configuracion()
{
  maSockets = new Socket[8][10];

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

  // OFFSETS MAPPING (SOMBRA NEGRA EN BORDES)
  offset1 = 280;
  offset2 = 0;
  offset4 = width;
  offset3 = width - 280;

  // VARIABLES CONFIGURABLES - No se reinician al morir o ganar
  debugMode = true;         // Activa atajos de teclado para funciones de depuracion 
  mappingHelper = false;    // Permite mover los offsets arrastrando los puntos de la sombra
  debugColision = false;    // Permite ver los objetos creados por la libreria de fisica
  debugCamera = false;      // Mostrar camara de Kinect
  kinectDetection = false;  // Deteccion de interaccion: Kinect/Mouse
  lightSystem = 1;          // 0 = Sin iluminacion, 1 = Iluminacion 2D, 2 = Iluminacion 3D
  lightIntensity = 2;       // 1 = Baja intensidad, 2 = Intensidad media, 3 = Intensidad alta  --  Solo iluminacion 2D
  FPS = 60;                 // Frames por segundo de la aplicacion
  maxActivos = 2;           // Maxima cantidad de sockets activables simultaneamente, ignorado en debugMode
  diametroSocket = 35;      // Diametro de los ahujeros
}

