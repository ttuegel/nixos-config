{ config, pkgs, ... }:

let

  emacs = pkgs.emacsWithPackages (epkgs: with epkgs; [
    use-package diminish bind-key
    monokai-theme
    evil evil-surround evil-indent-textobject
    rainbow-delimiters smartparens evil-cleverparens
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
    haskell-mode dante
    org
    rust-mode cargo flycheck-rust
    notmuch w3m
    pkgs.nix
    shimbun
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
