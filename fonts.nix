{ config, pkgs, ... }:

{
  environment.etc."fonts/conf.d/50-defaults.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias><family>sans-serif</family>
        <prefer><family>DejaVu Sans</family></prefer></alias>
      <alias><family>serify</family>
        <prefer><family>DejaVu Serif</family></prefer></alias>
      <alias><family>monospace</family>
        <prefer><family>DejaVu Sans Mono</family></prefer></alias>
    </fontconfig>
  '';

  fonts = {
    fontconfig = {
      autohint = false;
      embeddedBitmaps = false;
      user = false;
      hintStyle = "full";
      subpixelOrder = "rgb";
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
    liberation_ttf
  ];
}
