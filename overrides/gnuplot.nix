self: super:

{
  gnuplot = super.gnuplot.override { withQt = true; qt = self.qt4; };
}
