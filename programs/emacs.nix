{ config, pkgs, ... }:

let

  # Use GTK 3
  emacs = pkgs.emacs25.override {
    withGTK2 = false;
    withGTK3 = true;
    inherit (pkgs) gtk3;
  };

  autostartEmacsDaemon = pkgs.writeTextFile {
    name = "autostart-emacs-daemon";
    destination = "/etc/xdg/autostart/emacs-daemon.desktop";
    text = ''
      [Desktop Entry]
      Name=Emacs Server
      Type=Application
      Exec=${emacs}/bin/emacs --daemon
    '';
  };

in

{
  environment.systemPackages = [ autostartEmacsDaemon emacs ];
}
