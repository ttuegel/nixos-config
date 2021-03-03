{ config, lib, pkgs, ... }:

{
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Iosevka Custom" "Hack" "Source Code Pro" "DejaVu Sans Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
    allowBitmaps = false;
    allowType1 = false;
    includeUserConf = false;
  };

  fonts.fonts = with pkgs; with lib; [
    cm_unicode
    corefonts
    dejavu_fonts
    eb-garamond
    emojione
    font-awesome_4
    gentium
    iosevka-custom
    iosevka-custom-terminal
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro
    source-sans-pro
    source-serif-pro
    tex-gyre.adventor
    tex-gyre.bonum
    tex-gyre.chorus
    tex-gyre.cursor
    tex-gyre.heros
    tex-gyre.pagella
    tex-gyre.schola
    tex-gyre.termes
    tex-gyre-bonum-math
    tex-gyre-pagella-math
    tex-gyre-schola-math
    tex-gyre-termes-math
    vistafonts
  ];
}
