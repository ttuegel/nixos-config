{ config, pkgs, ... }:

let

  # Use GTK 3
  emacs =
    let
      withGTK = {
        withGTK2 = false;
        withGTK3 = true;
        inherit (pkgs) gtk3;
      };
    in
      (pkgs.emacsPackagesNgGen (pkgs.emacs25.override withGTK)).emacsWithPackages
      (epkgs: with epkgs; [ notmuch ]);

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
