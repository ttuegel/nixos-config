{ config, lib, pkgs, ... }:

{
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Iosevka" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
    allowBitmaps = false;
    allowType1 = false;
    includeUserConf = false;

    localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <match target="font">
          <test name="family" compare="contains">
            <string>Iosevka</string>
          </test>
          <edit name="fontfeatures" mode="append">
            <string>cv32=3</string> <!-- g = single-storey-serifless -->
            <string>cv34=8</string> <!-- i = tailed-serifed -->
            <string>cv37=8</string> <!-- l = tailed-serifed -->
            <string>cv71=4</string> <!-- 0 = dotted -->
            <string>cv75=1</string> <!-- 4 = closed -->
            <string>cv82=6</string> <!-- * = hex-low -->
            <string>cv87=1</string> <!-- { = straight -->
          </edit>
        </match>

        <match target="font">
          <test name="family" compare="contains">
            <string>Iosevka</string>
          </test>
          <test name="slant" compare="eq">
            <const>italic</const>
          </test>
          <edit name="fontfeatures" mode="append">
            <string>cv36=2</string> <!-- k = curly-serifless -->
            <string>cv49=2</string> <!-- y = straight-turn -->
          </edit>
        </match>
      </fontconfig>
    '';
  };

  fonts.fonts = with pkgs; with lib;
    [
      cm_unicode
      corefonts
      dejavu_fonts
      eb-garamond
      emacs-all-the-icons-fonts
      font-awesome_4
      gentium
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      vistafonts
    ]
    ++ lib.attrValues tex-gyre
    ++ lib.attrValues tex-gyre-math;

}
