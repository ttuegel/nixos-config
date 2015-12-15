{ pkgs, ... }:

let
  autostartDropbox = pkgs.runCommand "autostart-dropbox"
    { inherit (pkgs) dropbox; }
    ''
      mkdir -p "$out/etc/xdg/autostart"
      ln -s "$dropbox/share/applications/dropbox.desktop" \
          "$out/etc/xdg/autostart/dropbox.desktop"
    '';
in
{
  environment.systemPackages = [ autostartDropbox pkgs.dropbox ];
}
