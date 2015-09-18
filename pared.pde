void pared()
{
  pushStyle();
  image(pared, 0, 0);
  tint(255, contadorCracksPared.step());
  image(cracks, 0, 0);
  popStyle();
}
