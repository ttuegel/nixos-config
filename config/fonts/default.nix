{ config, lib, pkgs, ... }:

{
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Iosevka Term" "Hack" "Source Code Pro" "DejaVu Sans Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
    allowBitmaps = false;
    allowType1 = false;
    includeUserConf = false;
  };

  fonts.fonts = with pkgs; with lib; [
    cm_unicode
    dejavu_fonts
    font-awesome-ttf
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro
    source-sans-pro
    source-serif-pro
    vistafonts
    corefonts
    iosevka-type
    iosevka-term
  ];
}
