{ config, pkgs, ... }:

let

  emacs = pkgs.emacsWithPackages (epkgs: with epkgs; [
    use-package diminish bind-key
    rainbow-delimiters smartparens
    /* Evil */ evil-surround evil-indent-textobject evil-cleverparens avy undo-tree
    helm
    /* Git */ magit git-timemachine
    /* LaTeX */ auctex helm-bibtex cdlatex company-math
    markdown-mode
    flycheck
    pkgs.ledger
    yaml-mode
    company
    /* Haskell */ haskell-mode flycheck-haskell
    /* Org */ org org-ref
    rust-mode cargo flycheck-rust
    /* mail */ notmuch messages-are-flowing
    /* Nix */ pkgs.nix nix-buffer
    spaceline # modeline beautification
    winum eyebrowse # window management
    auto-compile
    /* Maxima */ pkgs.maxima
    visual-fill-column
    melpaStablePackages.idris-mode helm-idris

    which-key  # display keybindings after incomplete command
    helm-descbinds  # describe-bindings in helm
    company-ghci  # provide completions from inferior ghci
    base16-theme
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
