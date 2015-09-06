void inicializar()
{
  lightSystem = 1;        // 0 = Sin iluminacion, 1 = Iluminacion 2D, 2 = Iluminacion 3D
  lightIntensity = 1;     // 0 = Baja intensidad, 1 = Intensidad media, 2 = Intensidad alta  --  Solo iluminacion 2D
  mouseApretado = false;
  gameOver = false;
  FPS = 60;
  cantActivos = 0;
  maxActivos = 99;
  ordenSogas = 0;

  if (lightIntensity == 0)
  {
    darkness = loadImage("data/luces/lowLight.png");
  } else if (lightIntensity == 1)
  {
    darkness = loadImage("data/luces/midLight.png");
  } else if (lightIntensity == 2)
  {
    darkness = loadImage("data/luces/highLight.png");
  }

  mundo = new FWorld();  // CREA EL MUNDO PARA LA LIBRERIA DE FISICA
  mundo.clear();
  maSockets = new Socket[8][10];
  magma = new Lava();
  piedra = new Piedra(250, 25, 50);  // Constructor (POSX, POSY, RADIO)
  roberto = new Personaje(int(random(width/4, width*3/4)), height-32); // Constructor (POSX, POSY)

  // Vibracion de la luz, solo LightSystem = 2
  contadorLights = new Contador(1, 50, 2); // Constructor (MIN, MAX, DELAY)

  /*
   sombraIzq = new FBox(900, 5);
   sombraDer = new FBox(900, 5);
   sombraIzq.setPosition(150, height/2);
   sombraDer.setPosition(width - 150, height/2);
   sombraIzq.adjustRotation(degrees(-90));
   sombraDer.adjustRotation(degrees(90));
   sombraIzq.setStatic(true);
   sombraDer.setStatic(true);
   mundo.add(sombraIzq);
   mundo.add(sombraDer);
   */

  //mundo.setEdges();
  //mundo.remove(mundo.top);
  //mundo.remove(mundo.bottom);
  mundo.setGravity( 0, 1000 );
  mundo.setGrabbable(false);

  // MAPA DE SOCKETS
  int[][] socketMap = 
    {{0, 0, 0, 1, 2, 1, 0, 0, 0, 0}, 
    {0, 0, 1, 2, 1, 2, 1, 0, 0, 0}, 
    {0, 0, 2, 1, 2, 1, 2, 0, 0, 0}, 
    {0, 0, 1, 2, 1, 2, 2, 0, 0, 0}, 
    {0, 2, 2, 1, 2, 1, 1, 2, 0, 0}, 
    {0, 1, 2, 2, 1, 2, 2, 1, 0, 0}, 
    {0, 2, 1, 2, 2, 1, 1, 2, 0, 0}, 
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}};

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
}