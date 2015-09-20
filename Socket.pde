class Socket
{
  int grosor;
  int posX;
  int posY;
  int posXDeteccion;
  int posYDeteccion;
  int orden;
  String estado;
  color colr;
  Cuerda miCuerda;

  Socket(int _posX, int _posY, String _estado)
  {
    posX = _posX;
    posY = _posY;
    estado = _estado;
    grosor = diametroSocket;
    posXDeteccion = round(posX/1.6);
    posYDeteccion = round(posY/1.6);
  }

  void dibujar()
  {
    if (kinectDetection || debugCamera)
    {
      if (estado == "soga" || estado == "disponible")
      {
        int grosorDeteccion = grosor - 5;
        PImage socketArea = capturaKinect.get( posXDeteccion-round(grosorDeteccion/3.2), posYDeteccion-round(grosorDeteccion/3.2), round(grosorDeteccion/1.6), round(grosorDeteccion/1.6));

        int redAvg = 0;
        int greenAvg = 0;
        int blueAvg = 0;

        for (int i = 0; i < socketArea.pixels.length; i++)
        {
          redAvg += red(socketArea.pixels[i]);
          greenAvg += green(socketArea.pixels[i]);
          blueAvg += blue(socketArea.pixels[i]);
        }

        redAvg = (redAvg/socketArea.pixels.length);
        greenAvg = (greenAvg/socketArea.pixels.length);
        blueAvg = (blueAvg/socketArea.pixels.length);

        /*
        if (redAvg > 100)
         {
         println(redAvg, greenAvg, blueAvg);
         }
         */


        if (debugCamera)
        {
          pushStyle();
          fill(redAvg, greenAvg, blueAvg);
          stroke(150, 255, 150);
          rectMode(CENTER);
          rect(round(posXDeteccion*1.6), round(posYDeteccion*1.6), int(grosorDeteccion), int(grosorDeteccion));
          popStyle();
        }

        if (estado == "disponible"  && (cantActivos < maxActivos || debugMode) && redAvg > 100 && redAvg - greenAvg > 50 && redAvg - blueAvg > 50)
        {
          ++cantActivos;
          estado = "soga";
          miCuerda = new Cuerda(posX, posY, this);
          ++ordenSogas;
          orden = ordenSogas;
        } else if (estado == "soga" && (redAvg < 80 || redAvg - greenAvg < 30 || redAvg - blueAvg < 30))
        {

          miCuerda.destroy();
          miCuerda = null;
          --cantActivos;
          estado = "disponible";
        }
      }
    } else if (!kinectDetection)
    {
      if (dist(mouseX, mouseY, posX, posY) < grosor/2 && mouseApretado)
      {
        if (estado == "disponible"  && (cantActivos < maxActivos || debugMode))
        {
          ++cantActivos;
          estado = "soga";
          miCuerda = new Cuerda(posX, posY, this);
          ++ordenSogas;
          orden = ordenSogas;
        } else if (estado == "soga")
        {

          miCuerda.destroy();
          miCuerda = null;
          --cantActivos;
          estado = "disponible";
        }
      }
    }

    if (!debugCamera)
    {
      pushStyle();
      if (estado == "soga")
      {
        if (debugMode)
        {
          strokeWeight(2);
          stroke(255, 0, 0);
          fill(0);
        } else
        {
          noStroke();
          fill(0);                 // Este fill podria no estar en la version final, para proyectar sobre la estaca o gancho al colocarlos.
        }
      } else
      {
        noStroke();
        fill(0);
      }
      if (estado == "soga" || estado == "disponible")
      {
        ellipse(posX, posY, grosor, grosor);
      }
      popStyle();
    }
  }


  int getSocketHeight()
  {
    return round(float(posY - 16) / ( float(height)/float(maSockets.length-1)));
  }

  int getSocketWidth()
  {
    return round(float(posX - 56) / ( float(width)/float(maSockets[0].length-1)));
  }
}

