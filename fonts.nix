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
      hintStyle = "slight";
    };

    infinality = {
      enable = true;
      qtSubpixel = true;
      substitutions = false;
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    freetype_subpixel = pkgs.freetype.override {
      useEncumberedCode = true;
      useInfinality = true;
    };
  };
  environment.systemPackages = [ pkgs.freetype_subpixel ];

  environment.variables = {
    LD_LIBRARY_PATH = [ "${pkgs.freetype_subpixel}/lib" ];
  };

  fonts.extraFonts = with pkgs; [
    dejavu_fonts
    corefonts
    vistafonts
    liberation_ttf
  ];
}
