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
    emacs-all-the-icons-fonts
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
    tex-gyre-math.bonum
    tex-gyre-math.pagella
    tex-gyre-math.schola
    tex-gyre-math.termes
    vistafonts
  ];
}
