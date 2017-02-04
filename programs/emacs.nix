{ config, pkgs, ... }:

let

  emacs =
    # Use GTK 3
    let emacsGtk3 = pkgs.emacs25.override {
          withGTK2 = false;
          withGTK3 = true;
          inherit (pkgs) gtk3;
        };
    # Don't use the ugly, badly sized GTK scroll bars
    in emacsGtk3.overrideDerivation (drv: {
      configureFlags =
        (drv.configureFlags or []) ++ [ "--without-toolkit-scroll-bars" ];
    });

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
