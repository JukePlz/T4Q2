boolean imagesCached()
{
  boolean check = true;

  // LA IMAGEN TODAVIA ESTA CARGANDO
  if (lava.width == 0 || pared.width == 0 || cracks.width == 0 || sogaSegmento.width == 0)
  {
    check = false;
  }

  for (int i = 0; i < roca.length; i++)
  {
    if (roca[i].width == 0)
    {
      check = false;
    }
  }

  for (int i = 0; i < magmaRoca.length; i++)
  {
    if (magmaRoca[i].width == 0)
    {
      check = false;
    }
  }

  for (int i = 0; i < robertoSprite.length; i++)
  {
    for (int a = 0; a < robertoSprite[i].length; a++)
    {
      if (robertoSprite[i][a] != null && robertoSprite[i][a].width == 0)
      {
        check = false;
      }
    }
  }

  // ERROR AL CARGAR IMAGENES
  if (lava.width == -1 || pared.width == -1 || cracks.width == -1 || sogaSegmento.width == -1)
  {
    println("ERROR EN CARGA DE RECURSOS: SPRITES PARED/LAVA/CRACKS/CUERDA.");
    exit();
  }

  for (int i = 0; i < roca.length; i++)
  {
    if (roca[i].width == -1)
    {
      println("ERROR EN CARGA DE RECURSOS: SPRITES ROCAS. Indice " + i );
      exit();
    }
  }

  for (int i = 0; i < magmaRoca.length; i++)
  {
    if (magmaRoca[i].width == -1)
    {
      println("ERROR EN CARGA DE RECURSOS: SPRITES MAGMA ROCAS. Indice " + i );
      exit();
    }
  }

  for (int i = 0; i < robertoSprite.length; i++)
  {
    for (int a = 0; a < robertoSprite[i].length; a++)
    {
      if (robertoSprite[i][a] != null && robertoSprite[i][a].width == -1)
      {
        println("ERROR EN CARGA DE RECURSOS: SPRITES ROBERTO. Indice [" + i + "][" + a + "]");
        exit();
      }
    }
  }

  imagesCached = check;
  return check;
}