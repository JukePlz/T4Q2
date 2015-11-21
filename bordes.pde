void bordes()
{
  bordeIzq.setStart(offset1, 0);
  bordeIzq.setEnd(offset2, 768);
  bordeDer.setStart(offset4, 768);
  bordeDer.setEnd(offset3, 0);

  graph.pushStyle();
  graph.fill(0);

  // MARCO IZQUIERDO
  graph.beginShape();
  graph.vertex(0, 0);               // FIJO
  graph.vertex(offset1, 0);         // CONFIGURABLE
  graph.vertex(offset2, 768);       // CONFIGURABLE
  graph.vertex(0, 768);             // FIJO
  graph.endShape();

  // MARCO DERECHO
  graph.beginShape();
  graph.vertex(width, 0);           // FIJO
  graph.vertex(offset3, 0);         // CONFIGURABLE
  graph.vertex(offset4, 768);       // CONFIGURABLE
  graph.vertex(width, 768);         // FIJO
  graph.endShape();

  graph.popStyle();
}
