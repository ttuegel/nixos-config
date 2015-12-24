{ config, pkgs, ... }:

let

  emacs = pkgs.emacsWithPackages
    (with pkgs.emacsPackages; with pkgs.emacsPackagesNg; [
      ace-jump-mode
      auctex
      company
      diminish
      evil
      evil-indent-textobject
      evil-leader
      evil-surround
      flycheck
      git-auto-commit-mode
      git-timemachine
      haskell-mode
      helm
      idris-mode
      pkgs.ledger
      magit
      markdown-mode
      monokai-theme
      org-plus-contrib
      rainbow-delimiters
      undo-tree
      use-package
    ]);

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
