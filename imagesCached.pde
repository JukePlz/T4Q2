boolean imagesCached()
{
  boolean check = true;

  // LA IMAGEN TODAVIA ESTA CARGANDO
  if (lava.width == 0 || pared.width == 0 || cracks.width == 0 || sogaSegmento.width == 0 || casco.width == 0)
  {
    check = false;
  }

  if (bug.width == -1 || kinect.width == -1 || noKinect.width == -1 || map.width == -1 || noMap.width == -1 || colision.width == -1 || noColision.width == -1)
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

  for (int i = 0; i < ganaste.length; i++)
  {
    if (ganaste[i].width == 0)
    {
      check = false;
    }
  }

  for (int i = 0; i < perdiste.length; i++)
  {
    if (perdiste[i].width == 0)
    {
      check = false;
    }
  }

  // ERROR AL CARGAR IMAGENES
  if (lava.width == -1 || pared.width == -1 || cracks.width == -1 || sogaSegmento.width == -1 || casco.width == -1)
  {
    println("ERROR EN CARGA DE RECURSOS: SPRITES PARED/LAVA/CRACKS/CUERDA.");
    exit();
  }

  if (bug.width == -1 || kinect.width == -1 || noKinect.width == -1 || map.width == -1 || noMap.width == -1 || colision.width == -1 || noColision.width == -1)
  {
    println("ERROR EN CARGA DE RECURSOS: ICONOS.");
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

  for (int i = 0; i < ganaste.length; i++)
  {
    if (ganaste[i].width == -1)
    {
      println("ERROR EN CARGA DE RECURSOS: PANTALLA DE GANASTE.");
      exit();
    }
  }

  for (int i = 0; i < perdiste.length; i++)
  {
    if (perdiste[i].width == -1)
    {
      println("ERROR EN CARGA DE RECURSOS: PANTALLA DE PERDISTE.");
      exit();
    }
  }

  imagesCached = check;
  return check;
}

