{ config, lib, pkgs, ... }:

with lib;

let fontconfigBool = x: if x then "true" else "false";
    upstreamConf = "${pkgs.fontconfig}/etc/fonts/conf.d";
in
{

  options = {

    fonts = {

      fontconfig = {

        enable = mkOption {
          type = types.bool;
          default = true;
          description = ''
            If enabled, a Fontconfig configuration file will be built
            pointing to a set of default fonts.  If you don't care about
            running X11 applications or any other program that uses
            Fontconfig, you can turn this option off and prevent a
            dependency on all those fonts.
          '';
        };

        localConf = mkOption {
          type = types.string;
          default = ''
            <?xml version='1.0'?>
            <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
            <fontconfig>

              <!-- Settings for all fonts. -->
              <match target="font">

                <!-- Set the default hinting style. -->
                <edit mode="assign" name="hintstyle">
                  <const>hintslight</const>
                </edit>

              </match>

            </fontconfig>
          '';
          description = ''
            System-wide Fontconfig settings in
            <filename>/etc/fonts/local.conf</filename>.
          '';
        };

      };


    };

  };


  config =
    let fontconfig = config.fonts.fontconfig;
    in mkIf fontconfig.enable {

      # Bring in the default (upstream) fontconfig configuration.
      environment.etc."fonts/fonts.conf".source =
        pkgs.makeFontsConf { fontDirectories = config.fonts.fonts; };

      environment.etc."fonts/local.conf".text = fontconfig.localConf;

      # FIXME: This variable is no longer needed, but we'll keep it
      # around for a while for applications linked against old
      # fontconfig builds.
      environment.variables = { FONTCONFIG_FILE = "/etc/fonts/fonts.conf"; };

      environment.systemPackages = [ pkgs.fontconfig ];

    };

}
