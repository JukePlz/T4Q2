// Processing 3.0b5 + Fisica

// IMPORTS
import fisica.*;

// FISICA
FWorld mundo;
FLine bordeIzq;
FLine bordeDer;

// OBJETOS
Socket[][] maSockets;
Lava magma;
Piedra piedra;
Personaje roberto;
Cuerda cuerda;
Contador contadorLights;
Contador contadorCracksPared;
Contador contadorCracksRocas;

// OFFSETS MAPPING (SOMBRA NEGRA EN BORDES)
int offset1;
int offset2;
int offset4;
int offset3;

// OTRAS VARIABLES
int FPS;
int cantActivos;
int maxActivos;
int ordenSogas;
int lightSystem;
int lightIntensity;
boolean mappingHelper;
boolean debugColision;
boolean mouseApretado;
boolean gameOver;

// VARIABLES GRAFICOS
PImage pared;
PImage cracks;
PImage lava;
PImage sogaSegmento;
PImage robertoImg;
PImage robertoImg2;
PImage darkness;
PImage aura;
PImage[] roca = new PImage[4];
PImage[] magmaRoca = new PImage[4];

void setup()
{
  size(1024, 768, P2D);  // Solamente usamos el render 3D cuando el sistema de iluminacion esta activado. El render de JAVA2D va a ser reemplazado por FX2D, verificar que no se rompa nada cuando esto pase

  surface.setTitle("Inicializando...");

  Fisica.init(this);

  lava = loadImage("data/lava.png");
  pared = loadImage("data/pared.png");
  cracks = loadImage("data/cracks.png");
  sogaSegmento = loadImage("data/sogaSegmento.png");
  robertoImg = loadImage("data/personaje/idle_01.png");
  robertoImg2 = loadImage("data/personaje/idle_02.png");
  roca[0] = loadImage("data/roca1.png");
  roca[1] = loadImage("data/roca2.png");
  roca[2] = loadImage("data/roca3.png");
  roca[3] = loadImage("data/roca4.png");
  magmaRoca[0] = loadImage("data/magmaRoca1.png");
  magmaRoca[1] = loadImage("data/magmaRoca2.png");
  magmaRoca[2] = loadImage("data/magmaRoca3.png");
  magmaRoca[3] = loadImage("data/magmaRoca4.png");
  aura = loadImage("data/luces/aura.png");

  configuracion();
  inicializar();
}

void draw()
{
  if (lightSystem == 2)
  {
    pointLight(200+contadorLights.step(), 200, 200, roberto.posX, roberto.posY, 120+contadorLights.step());
  }

  if (frameCount % FPS/2 == 0) // Actualizamos el nombre de la ventana cada medio segundo (30 frames)
  {
    // FPS en marco de ventana
    surface.setTitle(int(frameRate) + " FPS" );  // La clase "frame" esta deprecada en processing 3.x por eso usamos "surface"
  }


  mundo.step();

  pared();

  for (int i = 0; i < maSockets.length; i++)
  {
    for (int a = 0; a < maSockets[0].length; a++)
    {
      maSockets[i][a].dibujar();  // SOCKETS
    }
  }

  roberto.dibujar(); // PERSONAJE
  piedra.dibujar();  // PIEDRAS

  if (lightSystem == 1)
  {
    pushStyle();
    imageMode(CENTER);
    image(darkness, roberto.posX, roberto.posY);
    popStyle();
  }

  magma.dibujar(); // LAVA
  bordes();        // BORDES

  if (debugColision)
  {
    mundo.draw(); // (SOLO PARA DEBUG) NO USAR! DIBUJA TODO ENCIMA DEL DRAW DE PROCESSING!!!
  }

  mouseApretado = false;
  contadorCracksRocas.step();

  if (gameOver)  // PANTALLA GAME OVER
  {
    fill(0, 200);
    rect(0, 0, width, height);
    //background(0, 150);
    fill(255);
    textSize(30);
    text("Game Over!", width/2, height/2);
    noLoop();
  }
}

void mousePressed()
{
  mouseApretado = true;

  if (gameOver)
  {
    inicializar();
    loop();
  }
}

void mouseDragged()
{
  if (mappingHelper)  // Eso podria tener una mejor verificacion para el drag, utilizando estados
  {
    if ((dist(offset1, 0, mouseX, 0) < 40) && mouseY < height/2)
    {
      println("offset 1: " + mouseX);
      offset1 = mouseX;
    } else if ((dist(offset2, 0, mouseX, 0) < 40) && mouseY > height/2)
    {
      println("offset 2: " + mouseX);
      offset2 = mouseX;
    } else if ((dist(offset3, 0, mouseX, 0) < 40) && mouseY < height/2)
    {
      println("offset 3: " + mouseX);
      offset3 = mouseX;
    } else if ((dist(offset4, 0, mouseX, 0) < 40) && mouseY > height/2)
    {
      println("offset 4: " + mouseX);
      offset4 = mouseX;
    }
  }
}

void contactStarted( FContact contact )
{
  FBody cuerpo1 = contact.getBody1();
  FBody cuerpo2 = contact.getBody2();

  if (cuerpo1.getName() == null || cuerpo2.getName() == null)
  {
    return;
  }

  if ((cuerpo1.getName().substring(0, min(cuerpo1.getName().length(), 4)).equals("roca") && cuerpo2.getName() == "roberto") || (cuerpo1.getName() == "roberto" && cuerpo2.getName().substring(0, min(cuerpo2.getName().length(), 4)).equals("roca"))) 
  {
    roberto.estado = "colision";
  }

  if (roberto.estado == "cayendo") {
    if (cuerpo1.getName().substring(0, min(cuerpo1.getName().length(), 6)).equals("cuerda") && cuerpo2.getName() == "robertoTemp") 
    {
      roberto.estado = cuerpo1.getName();
      roberto.colisionCuerda = cuerpo1;
    } else if (cuerpo1.getName() == "robertoTemp" && cuerpo2.getName().substring(0, min(cuerpo2.getName().length(), 6)).equals("cuerda"))
    {
      roberto.estado = cuerpo2.getName();
      roberto.colisionCuerda = cuerpo2;
    }
  }
}