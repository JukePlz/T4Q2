void inicializar()
{
  mouseApretado = false;
  gameOver = false;
  cantActivos = 0;
  maxActivos = 99;
  ordenSogas = 0;

  mundo = new FWorld();  // CREA EL MUNDO PARA LA LIBRERIA DE FISICA
  mundo.clear();
  maSockets = new Socket[8][10];
  magma = new Lava();
  piedra = new Piedras(250, 25, 50);
  roberto = new Personaje(int(random(width/4, width*3/4)), height-16);

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
        maSockets[i][a] = new Socket(width/(maSockets[0].length -1) * a +56, height/(maSockets.length -1) * i +16, "oculto" );
      } else if (socketMap[i][a] == 2 )
      {
        maSockets[i][a] = new Socket(width/(maSockets[0].length -1) * a +56, height/(maSockets.length -1) * i +16, "disponible" );
      }
    }
  }
}