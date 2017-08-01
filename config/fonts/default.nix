{ config, lib, pkgs, ... }:

let iosevka-type = pkgs.callPackage ./iosevka-custom.nix {
      # design='type v-l-italic v-i-italic v-zero-dotted v-asterisk-high v-at-long v-brace-straight'
      set = "type";
      src = ./iosevka-type.tar.xz;
    };
in
let iosevka-term = pkgs.callPackage ./iosevka-custom.nix {
      # design='term v-l-italic v-i-italic v-zero-dotted v-asterisk-high v-at-long v-brace-straight'
      set = "term";
      src = ./iosevka-term.tar.xz;
    };
in

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
    dejavu_fonts
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
