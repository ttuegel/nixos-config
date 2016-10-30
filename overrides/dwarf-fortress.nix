self: super:

{
  dwarf-fortress = super.dwarf-fortress.override {
    theme = "gemset";
    enableDFHack = true;
  };
}
