{ config, pkgs, ... }:

{
  fonts = {
    fontconfig = {
      autohint = false;
      embeddedBitmaps = false;
      user = true;
      hintStyle = "full";
      subpixelOrder = "rgb";
      bitmaps = false;
    };

    infinality = {
      enable = true;
      qtSubpixel = true;
      substitutions = false;
    };
  };

  environment.variables = {
    QT_GRAPHICSSYSTEM = "native";
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    vistafonts
    corefonts
    wqy_microhei
  ];
}
