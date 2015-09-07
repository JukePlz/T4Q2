// Processing 3.0b5 + Fisica

// IMPORTS
import fisica.*;

// FISICA
FWorld mundo;
//FBox sombraIzq;
//FBox sombraDer;

// OBJETOS
Socket[][] maSockets;
Lava magma;
Piedra piedra;
Personaje roberto;
Contador contadorLights;

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
PImage lava;
PImage soga;
PImage robertoImg;
PImage robertoImg2;
PImage darkness;
PImage aura;
PImage[] roca = new PImage[4];

void setup()
{

  if (lightSystem == 2)
  {
    size(1024, 768, P3D);  // Solamente usamos el render 3D cuando el sistema de iluminacion esta activado
  } else
  {
    size(1024, 768);       // El render de JAVA2D va a ser reemplazado por FX2D, verificar que no se rompa nada cuando esto pase
  }

  surface.setTitle("Inicializando...");

  Fisica.init(this);

  lava = loadImage("data/lava.png");
  pared = loadImage("data/pared.png");
  soga = loadImage("data/soga.png");
  robertoImg = loadImage("data/personaje/idle_01.png");
  robertoImg2 = loadImage("data/personaje/idle_02.png");
  roca[0] = loadImage("data/roca1.png");
  roca[1] = loadImage("data/roca2.png");
  roca[2] = loadImage("data/roca3.png");
  roca[3] = loadImage("data/roca4.png");
  aura = loadImage("data/luces/aura.png");

  configuracion();
  inicializar();
}

void draw()
{
  if (lightSystem == 2)
  {
    //println(map(mouseX, 0, 1024, 0, 1), "mX: " + mouseX, mouseY);
    //shininess(5.0); 
    pointLight(200+contadorLights.step(), 200, 200, roberto.posX, roberto.posY, 120+contadorLights.step());
  }
  //ambientLight(100, 100, 100);
  //ambient(51, 26, 0);

  if (frameCount % FPS/2 == 0) // Actualizamos el nombre de la ventana cada medio segundo (30 frames)
  {
    // FPS en marco de ventana
    surface.setTitle(int(frameRate) + " FPS" );  // La clase "frame" esta deprecada en processing 3.x por eso usamos "surface"
  }


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

  if (lightSystem == 1)
  {
    pushStyle();
    imageMode(CENTER);
    image(darkness, roberto.posX, roberto.posY);
    popStyle();
  }

  magma.dibujar(); // LAVA
  //image(fondo, 0, 0); // OSCURIDAD  -- TODO: Reemplazar por mascara de vertex para mejor performance
  bordes();

  if (debugColision)
  {
    mundo.draw(); // (SOLO PARA DEBUG) NO USAR! DIBUJA TODO ENCIMA DEL DRAW DE PROCESSING!!!
  }

  mouseApretado = false;

  if (gameOver)
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

  if ((cuerpo1.getName().substring(0, 4).equals("roca") && cuerpo2.getName() == "roberto") || (cuerpo1.getName() == "roberto" && cuerpo2.getName().substring(0, 4).equals("roca"))) 
  {
    roberto.estado = "colision";
  }
}