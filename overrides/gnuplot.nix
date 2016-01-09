super: self:

{
  gnuplot = super.gnuplot.override { withQt = true; qt = self.qt4; };
}
