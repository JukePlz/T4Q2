class Socket //<>//
{
  int grosor;
  int posX;
  int posY;
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
  }

  void dibujar()
  {
    if (dist(mouseX, mouseY, posX, posY) < grosor/2 && mouseApretado)
    {
      if (estado == "disponible"  && (cantActivos < maxActivos))
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

    if (estado == "soga")
    {
      fill(255);
      miCuerda.dibujar();
    } else
    {
      fill(0);
    }
    if (estado == "soga" || estado == "disponible")
    {
      pushStyle();
      noStroke();
      ellipse(posX, posY, grosor, grosor);
      popStyle();
    }
  }

  int getSocketHeight()
  {
    return (posY - 16) / ( height/(maSockets.length-1));
  }

  int getSocketWidth()
  {
    return (posX - 56) / ( width/(maSockets[0].length-1));
  }
}