class Socket //<>//
{
  String estado;
  int id;
  int grosor;
  color colr;
  int posX;
  int posY;
  int orden;

  Socket(int _posX, int _posY, String _estado)
  {
    posX = _posX;
    posY = _posY;
    estado = _estado;
    grosor = 35;
  }

  void dibujar()
  {
    if (dist(mouseX, mouseY, posX, posY) < grosor/2 && mouseApretado)
    {
      if (estado == "disponible"  && (cantActivos < maxActivos))
      {
        ++cantActivos;
        estado = "soga";
        ++ordenSogas;
        orden = ordenSogas;
      } else if (estado == "soga")
      {
        --cantActivos;
        estado = "disponible";
      }
    }


    if (estado == "soga")
    {
      fill(255);
      soga();
    } else
    {
      fill(0);
    }
    if (estado == "soga" || estado == "disponible")
    {
      ellipse(posX, posY, grosor, grosor);
    }
  }

  void soga()
  {
    pushStyle();
    imageMode(CENTER);
    image(soga, posX, posY + 50);
    popStyle();
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