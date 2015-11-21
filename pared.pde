void pared()
{
  graph.pushStyle();
  graph.image(pared, 0, 0);
  graph.tint(255, contadorCracksPared.step());
  graph.image(cracks, 0, 0);
  graph.popStyle();
}
