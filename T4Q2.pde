// Processing 2.2 + Fisica + Keystone
// Requiere kinectCap en ejecucion

// IMPORTS
import fisica.*;
import ddf.minim.*;
import deadpixel.keystone.*;

// FISICA
FWorld mundo;
FLine bordeIzq;
FLine bordeDer;

// KEYSTONE
Keystone ks;
CornerPinSurface mapping;

// MINIM
Minim minim;
AudioPlayer player1; 
AudioPlayer player2; 

// OTROS OBJETOS
Socket[][] maSockets;
Socket socketDrag;
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
int diametroSocket;
int ordenSogas;
int lightSystem;
int lightIntensity;
int textTimer;
int gameOver;
int vida;
int keyCodeOffset;
boolean imagesCached;
boolean debugMode;
boolean mappingHelper;
boolean debugColision;
boolean debugCamera;
boolean kinectDetection;
boolean mouseApretado;
String debugText;
String renderType;

// GRAFICOS
PImage pared;
PImage cracks;
PImage lava;
PImage sogaSegmento;
PImage darkness;
PImage aura;
PImage casco;
PImage[] perdiste = new PImage[7];
PImage[] ganaste = new PImage[7];
PImage[] roca = new PImage[4];
PImage[] magmaRoca = new PImage[4];
PImage[][] robertoSprite = new PImage[7][5];

// ICONOS
PImage bug;
PImage kinect;
PImage noKinect;
PImage map;
PImage noMap;
PImage colision;
PImage noColision;

// BUFFER DE KINECTCAP
PImage capturaKinect = createImage(0, 0, RGB);
PImage capturaKinectTemp = createImage(0, 0, RGB);

// PGGRAPHICS MAPPING
PGraphics graph;

// CONSTANTES
final int IDLE = 0;
final int IDLE_2 = 1;
final int WALK_LEFT = 2;
final int WALK_RIGHT = 3;
final int CLIMB = 4;
final int JUMP_LEFT = 5;
final int JUMP_RIGHT = 6;

void setup()
{
  configuracion();

  if (lightSystem == 2)
  {
    renderType = P3D;
  } else
  {
    renderType = P2D;
  }

  size(1024, 768, renderType);  // Solamente usamos el render 3D cuando el sistema de iluminacion esta activado. El render de JAVA2D va a ser reemplazado por FX2D, verificar que no se rompa nada cuando esto pase.

  frame.setTitle("Inicializando...");

  Fisica.init(this);
  ks = new Keystone(this);
  minim = new Minim(this);

  player1 = minim.loadFile("data/1.WAV");
  player2 = minim.loadFile("data/piedra.mp3");

  lava = requestImage("data/lava.png");
  pared = requestImage("data/pared.png");
  cracks = requestImage("data/cracks.png");
  sogaSegmento = requestImage("data/sogaSegmento.png");
  casco = requestImage("data/casco.png");
  perdiste[0] = requestImage("data/gameover/pantalla1.png");
  perdiste[1] = requestImage("data/gameover/pantalla2.png");
  perdiste[2] = requestImage("data/gameover/pantalla3.png");
  perdiste[3] = requestImage("data/gameover/pantalla4.png");
  perdiste[4] = requestImage("data/gameover/pantalla5.png");
  perdiste[5] = requestImage("data/gameover/pantalla6.png");
  perdiste[6] = requestImage("data/gameover/pantalla7.png");
  ganaste[0] = requestImage("data/ganaste/pantalla1.png");
  ganaste[1] = requestImage("data/ganaste/pantalla2.png");
  ganaste[2] = requestImage("data/ganaste/pantalla3.png");
  ganaste[3] = requestImage("data/ganaste/pantalla4.png");
  ganaste[4] = requestImage("data/ganaste/pantalla5.png");
  ganaste[5] = requestImage("data/ganaste/pantalla6.png");
  ganaste[6] = requestImage("data/ganaste/pantalla7.png");
  roca[0] = requestImage("data/roca1.png");
  roca[1] = requestImage("data/roca2.png");
  roca[2] = requestImage("data/roca3.png");
  roca[3] = requestImage("data/roca4.png");
  magmaRoca[0] = requestImage("data/magmaRoca1.png");
  magmaRoca[1] = requestImage("data/magmaRoca2.png");
  magmaRoca[2] = requestImage("data/magmaRoca3.png");
  magmaRoca[3] = requestImage("data/magmaRoca4.png");

  bug = requestImage("data/iconos/bug.png");
  kinect = requestImage("data/iconos/kinect.png");
  noKinect = requestImage("data/iconos/noKinect.png");
  map = requestImage("data/iconos/map.png");
  noMap = requestImage("data/iconos/noMap.png");
  colision = requestImage("data/iconos/colision.png");
  noColision = requestImage("data/iconos/noColision.png");

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

  configuracion();
  inicializar();

  player1.loop();
  player1.play();
  player1.setGain(-20);

  mapping = ks.createCornerPinSurface( 1024, 768, 20 );
  graph = createGraphics( 1024, 768, P3D);


  text("", 0, 0); // PRECACHE DE LA FUNCION
}

void draw()
{
  background(0);
  graph.beginDraw();
  graph.clear();

  if (!player1.isPlaying())
  {
    player1.rewind();
    player1.play();
  }


  if (imagesCached == true)
  {

    if (lightSystem == 2)
    {
      graph.pointLight(200+contadorLights.step(), 200, 200, roberto.posX, roberto.posY, 120+contadorLights.step());
    }

    if (frameCount % FPS/2 == 0) // Actualizamos el nombre de la ventana cada medio segundo (30 frames)
    {
      // FPS en marco de ventana
      frame.setTitle(int(frameRate) + " FPS" );  // La clase "frame" esta deprecada en processing 3.x en ese caso reemplazar por "surface"
    }

    if ( vida < 1)
    {
      gameOver = 1;
    }

    if (frameCount%5 == 0)
    {
      File screenCap = new File("C:/screenCap.jpg");
      if (screenCap.exists())
      {
        capturaKinectTemp =  requestImage("C:/screenCap.jpg");
      }
    }
    if (capturaKinectTemp.width > 0)
    {
      capturaKinect = capturaKinectTemp;
      capturaKinectTemp = createImage(0, 0, RGB);
      File screenCap = new File("C:/screenCap.jpg");
      if (screenCap.exists())
      {
        screenCap.delete();
      }
    }

    mundo.step();  // CALCULAR FISICA
    pared();       // PARED FONDO

    if (socketDrag != null)
    {

      if (!debugCamera)
      {
        int distanciaMaxX = (width/(maSockets[0].length -1)/4);
        int distanciaMaxY = (height/(maSockets.length -1)/4);
        socketDrag.posX = max(min(mouseX, width/(maSockets[0].length -1) * socketDrag.getSocketWidth() +56 + distanciaMaxX), width/(maSockets[0].length -1) * socketDrag.getSocketWidth() +56 - distanciaMaxX);
        socketDrag.posY = max(min(mouseY, height/(maSockets.length -1) * socketDrag.getSocketHeight() +16 + distanciaMaxY), height/(maSockets.length -1) * socketDrag.getSocketHeight() +16 - distanciaMaxY);
      } else
      {
        int distanciaMaxX = (width/(maSockets[0].length -1)/2);
        int distanciaMaxY = (height/(maSockets.length -1)/2);
        //socketDrag.posXDeteccion = int((max(min(mouseX, width/(maSockets[0].length -1) * socketDrag.getSocketWidth() +56 + distanciaMaxX), width/(maSockets[0].length -1) * socketDrag.getSocketWidth() +56 - distanciaMaxX))/1.6);
        // socketDrag.posYDeteccion = int((max(min(mouseY, height/(maSockets.length -1) * socketDrag.getSocketHeight() +16 + distanciaMaxY), height/(maSockets.length -1) * socketDrag.getSocketHeight() +16 - distanciaMaxY))/1.6);
        socketDrag.posXDeteccion = int(mouseX/1.6);
        socketDrag.posYDeteccion = int(mouseY/1.6);
      }
    }


    for (int i = 0; i < maSockets.length; i++)
    {
      for (int a = 0; a < maSockets[0].length; a++)
      {
        if (!debugCamera && maSockets[i][a].estado == "soga" && gameOver == 0)
        {
          maSockets[i][a].miCuerda.dibujar();  // CUERDA
        }
      }
    }

    roberto.dibujar(); // PERSONAJE
    piedra.dibujar();  // PIEDRAS

    if (lightSystem == 1)
    {
      graph.pushStyle();
      graph.imageMode(CENTER);
      graph.image(darkness, roberto.posX, roberto.posY);
      graph.popStyle();
    }

    magma.dibujar(); // LAVA

    if (debugColision)
    {
      mundo.draw(); // (SOLO PARA DEBUG) NO USAR! DIBUJA TODO ENCIMA DEL DRAW DE PROCESSING!!!
    }

    if (gameOver != 0)  // PANTALLA GAME OVER
    {
      gameOver(gameOver);
    }

    hud();           // VIDA
    bordes();        // BORDES

    if (debugCamera)
    {
      graph.endDraw();
      mapping.render( graph );
    }

    if (debugCamera)
    {
      if (capturaKinect.width > 0)
      {
        image(capturaKinect, 0, 0, width, height);
      }
    }

    for (int i = 0; i < maSockets.length; i++)
    {
      for (int a = 0; a < maSockets[0].length; a++)
      {
        maSockets[i][a].dibujar();  // SOCKETS
      }
    }

    if (!debugCamera)
    {
      graph.endDraw();
      mapping.render( graph );
    }

    mouseApretado = false;
    contadorCracksRocas.step();






    if (debugMode)
    {
      pushStyle();
      tint(255, 200);
      image(bug, width -bug.width - 5, 5);

      if (kinectDetection)
      {
        image(kinect, width -kinect.width - 5, bug.height + 25);
      } else
      {
        image(noKinect, width -noKinect.width - 5, bug.height + 25);
      }

      if (mappingHelper)
      {
        image(map, width -map.width - 5, bug.height + kinect.height + 30);
      } else
      {
        image(noMap, width -noMap.width - 5, bug.height + kinect.height + 30);
      }

      if (debugColision)
      {
        image(colision, width -colision.width - 5, bug.height + kinect.height + map.height + 35);
      } else
      {
        image(noColision, width -noColision.width - 5, bug.height + kinect.height + map.height + 35);
      }
      popStyle();
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

void mouseReleased()
{
  if (socketDrag != null)
  {
    socketDrag = null;
  }
}

void mousePressed()
{
  if (!mappingHelper)
  {
    mouseApretado = true;
  }

  if (mouseButton == LEFT && mappingHelper)
  {
    if (socketDrag == null)
    {
      for (int i = 0; i < maSockets.length; i++)
      {
        for (int a = 0; a < maSockets[0].length; a++)
        {
          if (!debugCamera)
          {
            if (dist(maSockets[i][a].posX, maSockets[i][a].posY, mouseX, mouseY) < maSockets[i][a].grosor)
            {
              socketDrag = maSockets[i][a];
              break;
            }
          } else
          {
            if (dist(int((maSockets[i][a].posXDeteccion)*1.6), int((maSockets[i][a].posYDeteccion)*1.6), mouseX, mouseY) < maSockets[i][a].grosor - 5)
            {
              socketDrag = maSockets[i][a];
              break;
            }
          }
        }
      }
    }
  }
}

void keyPressed()
{
  if (key == '/')
  {
    debugMode = !debugMode;

    if (debugMode)
    {
      debugText = "Depuracion: Activada";
    } else
    {
      debugColision = false;
      debugCamera = false;
      mappingHelper = false;
      debugText = "Depuracion: Desactivada";
    }
    textTimer = 120;
  }
  if ( key == 'c' )
  {
    ks.toggleCalibration();
  } else if ( key == 's' )
  {
    ks.save();
  } else if ( key == 'l' )
  {
    ks.load();
  } 

  if (debugMode)
  {
    debugMode();
  }
}

void mouseDragged()
{
  if (mappingHelper)  // Eso podria tener una mejor verificacion para el drag, utilizando estados
  {
    if (mouseButton == RIGHT)
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

    if (!player2.isPlaying())
    {
      player2.rewind();
      player2.play();
    }

    if (roberto.invulnerable == false && roberto.timerInvul == 0)
    {
      --vida;
      roberto.invulnerable = true;
      roberto.timerInvul = 120;
    }
  }

  if ((cuerpo1.getName().substring(0, min(cuerpo1.getName().length(), 4)).equals("roca") && cuerpo2.getName() == "robertoTemp") || (cuerpo1.getName() == "robertoTemp" && cuerpo2.getName().substring(0, min(cuerpo2.getName().length(), 4)).equals("roca"))) 
  {
    if (roberto.invulnerable == false && roberto.timerInvul == 0)
    {
      --vida;
      roberto.invulnerable = true;
      roberto.timerInvul = 120;
    }
  }

  if (roberto.estado == "cayendo")
  {
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

