class Personaje
{
  FBox robertoLaCaja;
  FBox robertoLaCajaTemp;
  Socket eleccion = null;
  Socket sogaBloqueada = null;
  FBody colisionCuerda = null;

  int posX;
  int posY;
  int alto;
  int ancho;
  int sprite;
  int spriteFrame;
  float rotacion;
  boolean invulnerable;
  String estado = "quieto";

  Personaje(int _posX, int _posY)
  {
    posX = _posX;
    posY = _posY;
    alto = 64;
    ancho = 50;
    sprite = 0;
    spriteFrame = 0;
    rotacion = 0;
    invulnerable = false;
    robertoLaCaja = new FBox(ancho, alto);  // Dimensiones originalales: 25x32
    robertoLaCaja.setName( "roberto" );
    robertoLaCaja.setStatic(true);
    robertoLaCaja.setSensor(true);
    robertoLaCaja.setRestitution(2);
    robertoLaCaja.setFill(255, 0, 0);
    //robertoLaCaja.setGroupIndex(-1);
    mundo.add(robertoLaCaja);

    /*
    ArrayList<FBody> objetosMundo = mundo.getBodies();
     for (int i = 0; i < objetosMundo.size(); i++)
     {
     FBody objetoi = objetosMundo.get(i);
     if (objetoi.getName() == "roca")
     {
     pushStyle();
     fill(color(#c87e4d));
     noStroke();
     ellipse(objetoi.getX(), objetoi.getY(), radio, radio);
     popStyle();
     }
     }
     */
  }

  void dibujar()
  {
    think();

    if (estado != "cayendo")
    {
      robertoLaCaja.setPosition(posX, posY);
      robertoLaCaja.setRotation(rotacion);
    } else if (estado == "cayendo")
    {
      posX = int(robertoLaCajaTemp.getX());
      posY = int(robertoLaCajaTemp.getY());
    }

    pushStyle();
    rectMode(CENTER);
    imageMode(CENTER);
    noStroke();
    fill(255, 0, 0);
    pushMatrix();
    translate(posX, posY);
    rotate(rotacion);
    image(robertoSprite[sprite][spriteFrame], 0, 0);
    animateSprite();
    popMatrix();
    popStyle();
  }

  void think()
  {
    if (eleccion != null && estado == "moviendose")
    {
      if (eleccion.estado != "soga")
      {
        estado = "colision";
        eleccion = null;
        setSprite(IDLE);
      } else
      {
        if (posY == height-(alto/2))
        {
          if ( posX > eleccion.posX )
          {
            --posX;
            setSprite(WALK_LEFT);
          } else if ( posX < eleccion.posX )
          {
            ++posX;
            setSprite(WALK_RIGHT);
          } else if ( posY > eleccion.posY )
          {
            --posY;
            setSprite(CLIMB);
          } else if ( posY < eleccion.posY )
          {
            ++posY;
            setSprite(CLIMB);
          } else if (posY == eleccion.posY && posX == eleccion.posX)
          {
            estado = "quieto";
            setSprite(IDLE_2);
            rotacion = 0;
          }
        } else {
          FBody cuerdaEleccion = null;
          float cuerdaDist = -1;
          float rotacionAverage = 0;

          for (int i = 0; i < eleccion.miCuerda.cuerda.length; i++)
          {
            if (i != eleccion.miCuerda.cuerda.length-1) {
              rotacionAverage = rotacionAverage + eleccion.miCuerda.cuerda[i].getRotation();
            } else
            {
            }

            if (cuerdaDist == -1 || dist(posX, posY, eleccion.miCuerda.cuerda[i].getX(), eleccion.miCuerda.cuerda[i].getY()) < cuerdaDist)
            {
              cuerdaDist = dist(posX, posY, eleccion.miCuerda.cuerda[i].getX(), eleccion.miCuerda.cuerda[i].getY());
              cuerdaEleccion = eleccion.miCuerda.cuerda[i];
            }
          }
          rotacion = (rotacionAverage / float(eleccion.miCuerda.cuerda.length-1));
          posX = int(cuerdaEleccion.getX());

          if ( posY > eleccion.posY )
          {
            --posY;
            setSprite(CLIMB);
          } else if ( posY < eleccion.posY )
          {
            ++posY;
            setSprite(CLIMB);
          } else if (posY == eleccion.posY && posX == eleccion.posX)
          {
            estado = "quieto";
            setSprite(IDLE_2);
            rotacion = 0;
          }
        }
      }
    }

    if (magma.erupcionando == false && estado == "quieto" && eleccion != null &&eleccion.getSocketHeight() <= 6)
    {
      magma.erupcionando = true;
    } 
    if (piedra.cayendo == false && estado == "quieto" && eleccion != null && eleccion.getSocketHeight() <= 5)
    {
      piedra.cayendo = true;
    }

    if (estado.substring(0, min(estado.length(), 6)).equals("cuerda")) // AGARRARSE DE UNA CUERDA
    { 
      int tempPosX = int(estado.substring(6, 8));
      int tempPosY = int(estado.substring(8, 10));
      int angulo;

      if (sogaBloqueada != maSockets[tempPosY][tempPosX])
      {
        if (posX > colisionCuerda.getX())
        {
          angulo = 180;
        } else
        {
          angulo = 0;
        }
        float dx = 400 * cos( radians(angulo) );
        float dy = 400 * sin( radians(angulo) );

        colisionCuerda.setVelocity(dx, dy);
        estado = "moviendose";
        desactivarFisica();
        eleccion = maSockets[tempPosY][tempPosX];
        sogaBloqueada = eleccion;
      } else {
        estado = "cayendo";
      }
    } 
    if (estado != "cayendo")
    {
      if (estado == "quieto" && eleccion!=null && eleccion.getSocketHeight() == 0)  // SUBIO A LA CIMA (PANTALLA GANAR)
      {
        gameOver = 2;
      } else if (magma.alturaLava + 912 < posY)
      {
        gameOver = 1;
      } else if (posY == height-(alto/2))  // CAMINA HACIA LA PRIMERA CUERDA DESDE EL PISO.
      {
        int distancia = -1;
        Socket eleccionTemp = null;

        for (int i = 0; i < maSockets[0].length; i++)
        {
          if (maSockets[6][i].estado == "soga" && (distancia == -1 || distancia > dist(posX, 0, maSockets[6][i].posX, 0)))
          {
            distancia = int(dist(posX, 0, maSockets[6][i].posX, 0));
            eleccionTemp = maSockets[6][i];
          }
        }

        if (eleccionTemp != null)
        {
          estado = "moviendose";
          eleccion = eleccionTemp;
        }
      } else if ((eleccion != null && eleccion.estado != "soga") || estado == "colision") // SE CAE CON COLISION O AL PERDER LA CUERDA.
      {
        estado = "cayendo";
        activarFisica();
        setSprite(JUMP_LEFT);
      } else if (estado == "quieto")  // PATHFINDING PARA ARRIBA Y COSTADOS
      {
        int orden = -1;

        Socket eleccionTemp = null;
        for (int i = -1; i <= 1; i++)
        {
          if (maSockets[eleccion.getSocketHeight()-1][eleccion.getSocketWidth()+i].estado == "soga" && (orden == -1 || orden < maSockets[eleccion.getSocketHeight()-1][eleccion.getSocketWidth()+i].orden ))
          {
            orden = maSockets[eleccion.getSocketHeight()-1][eleccion.getSocketWidth()+i].orden;
            eleccionTemp = maSockets[eleccion.getSocketHeight()-1][eleccion.getSocketWidth()+i];
          }
        }
        if (eleccionTemp != null)  // ARRIBA
        {

          estado = "moviendose";
          if (eleccion.posX != eleccionTemp.posX)
          {
            sogaBloqueada = eleccion;
            estado = "cayendo";
            activarFisica();

            float velocidad = 400;
            int angulo;

            if (eleccion.posX > eleccionTemp.posX)
            {
              setSprite(JUMP_LEFT);
              angulo = -125;
            } else
            {
              setSprite(JUMP_RIGHT);
              angulo = -45;
            }

            float dx = velocidad * cos( radians(angulo) );
            float dy = velocidad * sin( radians(angulo) );

            robertoLaCajaTemp.setVelocity(dx, dy);
          } else
          {
            sogaBloqueada = eleccionTemp;
          }

          eleccion = eleccionTemp;
        } else  // PATHFINDING DE LOS COSTADOS
        {
          orden = eleccion.orden;

          for (int i = -1; i <= 1; i++)
          {
            if (i != 0 && maSockets[eleccion.getSocketHeight()][eleccion.getSocketWidth()+i].estado == "soga" && (orden < maSockets[eleccion.getSocketHeight()][eleccion.getSocketWidth()+i].orden ))
            {
              orden = maSockets[eleccion.getSocketHeight()][eleccion.getSocketWidth()+i].orden;
              eleccionTemp = maSockets[eleccion.getSocketHeight()][eleccion.getSocketWidth()+i];
            }
          }

          if (eleccionTemp != null)  // COSTADOS
          {
            sogaBloqueada = eleccion;
            estado = "cayendo";
            activarFisica();

            float velocidad = 400;
            int angulo;

            if (eleccion.posX > eleccionTemp.posX)
            {
              setSprite(JUMP_LEFT);
              angulo = -125;
            } else
            {
              setSprite(JUMP_RIGHT);
              angulo = -45;
            }

            float dx = velocidad * cos( radians(angulo) );
            float dy = velocidad * sin( radians(angulo) );

            robertoLaCajaTemp.setVelocity(dx, dy);

            eleccion = eleccionTemp;
          }
        }
      }
    } else if (estado == "cayendo" && posY >= height-(alto/2))
    {
      posY = height-(alto/2);
      rotacion = 0;
      estado = "quieto";
      setSprite(IDLE);
      desactivarFisica();
    } else if (estado == "cayendo" && eleccion != null && robertoLaCajaTemp.getGroupIndex() == -1 && dist(posX, 0, eleccion.posX, 0) < 10)
    {
      robertoLaCajaTemp.setGroupIndex(1);
    }

    if ( posY == height-(alto/2) && robertoLaCaja.isSensor() )
    {
      robertoLaCaja.setSensor(false);
    } else if (posY < height-(alto/2) && !robertoLaCaja.isSensor())
    {
      robertoLaCaja.setSensor(true);
    }
  }

  void activarFisica()
  {
    mundo.remove(robertoLaCaja);

    robertoLaCajaTemp = new FBox(ancho, alto);
    robertoLaCajaTemp.setPosition(posX, posY);
    robertoLaCajaTemp.setRotation(rotacion);
    robertoLaCajaTemp.setName( "robertoTemp" );
    robertoLaCajaTemp.setRestitution(0.4);
    //robertoLaCajaTemp.setSensor(true);
    //robertoLaCajaTemp.setGroupIndex(-1);
    mundo.add(robertoLaCajaTemp);
  }

  void desactivarFisica()
  {
    if (invulnerable)
    {
      invulnerable = false;
    }

    mundo.remove(robertoLaCajaTemp);
    robertoLaCajaTemp = null;
    mundo.add(robertoLaCaja);
  }

  void animateSprite()
  {
    int frameRateSprite = -1;

    if (sprite == WALK_LEFT || sprite == WALK_RIGHT)
    {
      frameRateSprite = 8;
    } else if (sprite == CLIMB)
    {
      frameRateSprite = 30;
    } else if (sprite == JUMP_LEFT)
    {
      frameRateSprite = 20;
    } else if (sprite == JUMP_RIGHT)
    {
      frameRateSprite = 20;
    }

    if (frameRateSprite != -1 && frameCount % frameRateSprite == 0)
    {

      if (spriteFrame == robertoSprite[sprite].length-1)
      {
        spriteFrame = 0;
      } else if (robertoSprite[sprite][spriteFrame+1] == null)
      {
        spriteFrame = 0;
      } else
      {
        ++spriteFrame;
      }
    }
  }

  void setSprite(int _spriteName)
  {
    if (sprite != _spriteName)
    {
      sprite = _spriteName;
      spriteFrame = 0;
    }
  }
}