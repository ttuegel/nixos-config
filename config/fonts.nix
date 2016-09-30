{ config, pkgs, ... }:

{
  fonts.fontconfig = {
    defaultFonts.monospace = [ "Source Code Pro" "DejaVu Sans Mono" ];
    hinting = {
      style = "slight";
      autohint = false;
    };
    ultimate = {
      allowBitmaps = false;
      enable = true;
    };
    includeUserConf = false;
  };

  fonts.fonts = with pkgs; with lib; [
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro
    source-sans-pro
    source-serif-pro
    vistafonts
  ];
}
