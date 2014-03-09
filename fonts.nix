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

  environment.etc."fonts/conf.d/10-subpixel.conf".text = ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>
    <match target="pattern">
      <edit name="rgba" mode="append"><const>rgb</const></edit>
    </match>
    </fontconfig>
  '';

  environment.etc."fonts/conf.d/11-hinting.conf".text = ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>
      <match target="font">
        <edit mode="assign" name="hinting"><bool>true</bool></edit>
        <edit mode="assign" name="hintstyle"><const>hintslight</const></edit>
      </match>
    </fontconfig>
  '';

  environment.etc."fonts/conf.d/12-no-bitmaps.conf".text = ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>
    <match target="font" >
         <edit name="embeddedbitmap" mode="assign">
             <bool>false</bool>
         </edit>
    </match>
    </fontconfig>
  '';

  nixpkgs.config.packageOverrides = pkgs: {
    freetype_subpixel = pkgs.freetype.override {
      useEncumberedCode = true;
      useInfinality = false;
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