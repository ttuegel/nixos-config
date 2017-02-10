{ config, pkgs, ... }:

let

  # Use GTK 3
  emacs = pkgs.emacsWithPackages (epkgs: with epkgs; [
    use-package
    diminish
    bind-key
    monokai-theme
    rainbow-delimiters
    evil evil-surround evil-indent-textobject
    undo-tree
    helm
    avy
    magit git-timemachine
    auctex helm-bibtex
    markdown-mode
    flycheck
    pkgs.ledger
    yaml-mode
    company
    haskell-mode
    dante
    org
    rust-mode cargo flycheck-rust
    notmuch
    w3m
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
