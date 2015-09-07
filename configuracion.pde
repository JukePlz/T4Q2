void configuracion()
{
  // OFFSETS MAPPING (SOMBRA NEGRA EN BORDES)
  offset1 = 278;
  offset2 = 0;
  offset4 = width;
  offset3 = width - 278;

  // VARIABLES CONFIGURABLES - No se reinician al morir o ganar
  mappingHelper = false;   // Permite mover los offsets arrastrando los puntos de la sombra
  debugColision = false;  // Permite ver los objetos creados por la libreria de fisica
  lightSystem = 1;        // 0 = Sin iluminacion, 1 = Iluminacion 2D, 2 = Iluminacion 3D
  lightIntensity = 1;     // 0 = Baja intensidad, 1 = Intensidad media, 2 = Intensidad alta  --  Solo iluminacion 2D
  FPS = 60;               // Frames por segundo de la aplicacion
  maxActivos = 99;        // Maxima cantidad de sockets activables simultaneamente
}