// Processing 3.0b5 + Fisica //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//

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

// FONTS
PFont splatter;

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
int textTimer;
int gameOver;
boolean imagesCached;
boolean debugMode;
boolean mappingHelper;
boolean debugColision;
boolean mouseApretado;
String debugText;

// VARIABLES GRAFICOS
PImage pared;
PImage cracks;
PImage lava;
PImage sogaSegmento;
PImage darkness;
PImage aura;
PImage[] roca = new PImage[4];
PImage[] magmaRoca = new PImage[4];
PImage[][] robertoSprite = new PImage[7][5];

// CONSTANTES
final int IDLE = 0;
final int IDLE_2 = 1;
final int WALK_LEFT = 2;
final int WALK_RIGHT = 3;
final int CLIMB = 4;
final int JUMP_LEFT = 5;
final int JUMP_RIGHT = 6;


void settings()
{
  String renderType;

  configuracion();

  if (lightSystem == 2)
  {
    renderType = P3D;
  } else
  {
    renderType = P2D;
  }

  size(1024, 768, renderType);  // Solamente usamos el render 3D cuando el sistema de iluminacion esta activado. El render de JAVA2D va a ser reemplazado por FX2D, verificar que no se rompa nada cuando esto pase
}

void setup()
{
  surface.setTitle("Inicializando...");

  Fisica.init(this);

  lava = requestImage("data/lava.png");
  pared = requestImage("data/pared.png");
  cracks = requestImage("data/cracks.png");
  sogaSegmento = requestImage("data/sogaSegmento.png");
  roca[0] = requestImage("data/roca1.png");
  roca[1] = requestImage("data/roca2.png");
  roca[2] = requestImage("data/roca3.png");
  roca[3] = requestImage("data/roca4.png");
  magmaRoca[0] = requestImage("data/magmaRoca1.png");
  magmaRoca[1] = requestImage("data/magmaRoca2.png");
  magmaRoca[2] = requestImage("data/magmaRoca3.png");
  magmaRoca[3] = requestImage("data/magmaRoca4.png");

  if (lightSystem == 1)
  {
    aura = loadImage("data/luces/aura.png");
  }

  robertoSprite[0][0] = requestImage("data/personaje/idle/idle_front.png");
  robertoSprite[1][0] = requestImage("data/personaje/idle/idle_back.png");

  robertoSprite[2][0] = requestImage("data/personaje/walk/caminar_izquierda_01.png");
  robertoSprite[2][1] = requestImage("data/personaje/walk/caminar_izquierda_02.png");
  robertoSprite[2][2] = requestImage("data/personaje/walk/caminar_izquierda_03.png");
  robertoSprite[2][3] = requestImage("data/personaje/walk/caminar_izquierda_04.png");
  robertoSprite[2][4] = requestImage("data/personaje/walk/caminar_izquierda_05.png");

  robertoSprite[3][0] = requestImage("data/personaje/walk/caminar_derecha_01.png");
  robertoSprite[3][1] = requestImage("data/personaje/walk/caminar_derecha_02.png");
  robertoSprite[3][2] = requestImage("data/personaje/walk/caminar_derecha_03.png");
  robertoSprite[3][3] = requestImage("data/personaje/walk/caminar_derecha_04.png");
  robertoSprite[3][4] = requestImage("data/personaje/walk/caminar_derecha_05.png");

  robertoSprite[4][0] = requestImage("data/personaje/climb/escalando_01.png");
  robertoSprite[4][1] = requestImage("data/personaje/climb/escalando_02.png");

  robertoSprite[5][0] = requestImage("data/personaje/jump/saltando_izquierda_01.png");
  robertoSprite[5][1] = requestImage("data/personaje/jump/saltando_izquierda_02.png");

  robertoSprite[6][0] = requestImage("data/personaje/jump/saltando_derecha_01.png");
  robertoSprite[6][1] = requestImage("data/personaje/jump/saltando_derecha_02.png");

  splatter = loadFont("SPLATTER-48.vlw");

  configuracion();
  inicializar();
}

void draw()
{
  if (imagesCached == true)
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

    mundo.step();  // CALCULAR FISICA

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

    if (gameOver != 0)  // PANTALLA GAME OVER
    {
      gameOver(gameOver);
    }

    if (debugText != null && textTimer > 0)  // TEXTO DE DEBUG EN PANTALLA
    {
      pushStyle();
      fill(0, 220, 0);
      stroke(3);
      textSize(20);
      text(debugText, 8, 21);
      popStyle();
    }
    --textTimer;
  } else // PANTALLA DE CARGA DE RECURSOS
  {
    if (imagesCached() == false)
    {
      pushStyle();

      // FONDO AMARILLO
      fill(255, 255, 0);
      rect(0, 0, width, height);

      // TRIANGULO
      fill(0);
      stroke(2);
      beginShape();
      vertex(width/4*1, height/4*3);  // LEFT
      vertex(width/2, height/4*1);    // MID
      vertex(width/4*3, height/4*3);  // RIGHT
      endShape();

      // SIGNO DE EXCLAMACION
      fill(255);
      ellipseMode(CENTER);
      ellipse(width/2, height/20*14, 30, 30);
      ellipse(width/2, height/20*11, 30, 150);

      // TEXTO
      fill(0);
      textSize(40);
      text("CARGANDO RECURSOS...", width/2 - 230, height/4*3 + 40);

      popStyle();
    }
  }
}

void mousePressed()
{
  mouseApretado = true;
}

void keyPressed()
{
  if (debugMode)
  {
    debugMode();
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