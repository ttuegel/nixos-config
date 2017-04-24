{ config, pkgs, ... }:

let

  emacs = pkgs.emacsWithPackages (epkgs: with epkgs; [
    use-package diminish bind-key
    rainbow-delimiters smartparens
    evil evil-surround evil-indent-textobject evil-cleverparens # vim
    undo-tree
    helm
    avy
    magit git-timemachine
    auctex helm-bibtex cdlatex # latex
    markdown-mode
    flycheck
    pkgs.ledger
    yaml-mode
    company
    haskell-mode dante # haskell
    org
    rust-mode cargo flycheck-rust
    notmuch # e-mail
    pkgs.nix
    spaceline # modeline beautification
    winum eyebrowse # window management
    auto-compile
    pkgs.maxima # for imaxima and imath
    visual-fill-column
    org-ref
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
