{ config, pkgs, ... }:

{
  fonts.fontconfig = {
    defaultFonts.monospace = [ "Source Code Pro" "DejaVu Sans Mono" ];
    ultimate.allowBitmaps = false;
    includeUserConf = false;
    hinting.style = "slight";
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
    corefonts
  ];
}
