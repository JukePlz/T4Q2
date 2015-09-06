class Personaje
{
  FBox robertoLaCaja;
  FBox robertoLaCajaTemp;
  Socket eleccion = null;

  int posX;
  int posY;
  int alto;
  int ancho;
  String estado = "quieto";

  PImage robertoCurrentImg = robertoImg;


  Personaje(int _posX, int _posY)
  {
    posX = _posX;
    posY = _posY;
    alto = 64;
    ancho = 50;
    robertoLaCaja = new FBox(ancho, alto);  //25 32
    mundo.add(robertoLaCaja);
    robertoLaCaja.setName( "roberto" );
    robertoLaCaja.setStatic(true);
    robertoLaCaja.setSensor(true);
    robertoLaCaja.setRestitution(0.4);

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
    //pointLight(255, 255, 255, posX, posY, 0);
    image(robertoCurrentImg, posX, posY);
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
      } else if ( posX > eleccion.posX )
      {
        --posX;
        robertoCurrentImg = robertoImg2;
      } else if ( posX < eleccion.posX )
      {
        ++posX;
        robertoCurrentImg = robertoImg;
      } else if ( posY > eleccion.posY )
      {
        --posY;
      } else
      {
        estado = "quieto";
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

    if (estado != "cayendo")
    {
      if (estado == "quieto" && eleccion!=null && eleccion.getSocketHeight() == 0)  // WIN
      {
        gameOver = true;
      } else if (magma.alturaLava + 912 < posY)
      {
        gameOver = true;
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
        robertoLaCaja.setPosition(0, 0);

        robertoLaCajaTemp = new FBox(25, 32);
        mundo.add(robertoLaCajaTemp);
        robertoLaCajaTemp.setName( "robertoTemp" );
        robertoLaCajaTemp.setRestitution(0.4);
        robertoLaCajaTemp.setDensity(1000);
        robertoLaCajaTemp.setPosition(posX, posY);
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
            if (eleccionTemp != null)  // COSTADOS
            {
              estado = "moviendose";
              eleccion = eleccionTemp;
            }
          }
        }
      }
    } else if (estado == "cayendo" && posY >= height-(alto/2))
    {
      posY = height-(alto/2);
      mundo.remove(robertoLaCajaTemp);
      robertoLaCajaTemp = null;
      estado = "quieto";
    }

    if ( posY == height-(alto/2) && robertoLaCaja.isSensor() )
    {
      robertoLaCaja.setSensor(false);
    } else if (posY < height-(alto/2) && !robertoLaCaja.isSensor())
    {
      robertoLaCaja.setSensor(true);
    }
  }
}