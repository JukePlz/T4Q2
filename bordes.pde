void bordes()
{
  bordeIzq.setStart(offset1, 0);
  bordeIzq.setEnd(offset2, 768);
  bordeDer.setStart(offset4, 768);
  bordeDer.setEnd(offset3, 0);

  pushStyle();
  fill(0);

  // MARCO IZQUIERDO
  beginShape();
  vertex(0, 0);               // FIJO
  vertex(offset1, 0);         // CONFIGURABLE
  vertex(offset2, 768);       // CONFIGURABLE
  vertex(0, 768);             // FIJO
  endShape();

  // MARCO DERECHO
  beginShape();
  vertex(width, 0);           // FIJO
  vertex(offset3, 0);         // CONFIGURABLE
  vertex(offset4, 768);       // CONFIGURABLE
  vertex(width, 768);         // FIJO
  endShape();

  popStyle();
}