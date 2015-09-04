// IMPORTS
import fisica.*;

// FISICA
FWorld mundo;
FBox sombraIzq;
FBox sombraDer;


// OBJETOS
Socket[][] maSockets;
Lava magma;
Piedras piedra;
Personaje roberto;

// CONSTANTES
PImage fondo;
PImage pared;
PImage lava;
PImage soga;
PImage robertoImg;
PImage robertoImg2;
PImage[] roca = new PImage[4];

boolean mouseApretado;
boolean gameOver;
int cantActivos;
int maxActivos;
int ordenSogas;

void setup()
{
  size( 1024, 768 );

  Fisica.init(this);

  lava = loadImage("data/lava.png");
  pared = loadImage("data/pared.png");
  fondo = loadImage("data/fondo.png");
  soga = loadImage("data/soga.png");
  robertoImg = loadImage("data/roberto.png");
  robertoImg2 = loadImage("data/roberto2.png");
  roca[0] = loadImage("data/roca1.png");
  roca[1] = loadImage("data/roca2.png");
  roca[2] = loadImage("data/roca3.png");
  roca[3] = loadImage("data/roca4.png");

  inicializar();
}

void draw()
{
  mundo.step();

  image(pared, 0, 0); // PARED

  for (int i = 0; i < maSockets.length; i++)
  {
    for (int a = 0; a < maSockets[0].length; a++)
    {
      maSockets[i][a].dibujar();  // SOCKETS
    }
  }

  roberto.dibujar(); // PERSONAJE
  piedra.dibujar(); // PIEDRAS
  magma.dibujar(); // LAVA
  image(fondo, 0, 0); // OSCURIDAD

  //mundo.draw(); // (SOLO PARA DEBUG) NO USAR! DIBUJA TODO ENCIMA DEL DRAW DE PROCESSING!!!

  mouseApretado = false;

  if (gameOver)
  {
    background(0);
    fill(255);
    textSize(30);
    text("Game Over!", width/2, height/2);
    noLoop();
  }
}

void mousePressed()
{
  //println(mouseX, mouseY);
  mouseApretado = true;

  if (gameOver)
  {
    inicializar();
    loop();
  }
}

void contactStarted( FContact contact )
{
  FBody cuerpo1 = contact.getBody1();
  FBody cuerpo2 = contact.getBody2();

  if ((cuerpo1.getName().substring(0, 4).equals("roca") && cuerpo2.getName() == "roberto") || (cuerpo1.getName() == "roberto" && cuerpo2.getName().substring(0, 4).equals("roca"))) 
  {
    roberto.estado = "colision";
    //println("boom");
  }
}