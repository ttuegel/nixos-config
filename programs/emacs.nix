{ config, pkgs, ... }:

let

  emacsPackages =
    pkgs.emacsPackagesNg.overrideScope
    (self: super: {
      evil = self.melpaPackages.evil;
      haskell-mode = self.melpaPackages.haskell-mode;
      flycheck-haskell = self.melpaPackages.flycheck-haskell;
      idris-mode = self.melpaPackages.idris-mode;
      use-package = self.melpaPackages.use-package;
    });

  emacs = emacsPackages.emacsWithPackages (epkgs: with epkgs; [
    use-package

    # Interface
    bind-key
    company
    ivy counsel swiper
    projectile  # project management
    visual-fill-column
    which-key  # display keybindings after incomplete command
    winum eyebrowse # window management

    # Themes
    diminish
    spaceline # modeline beautification

    # Delimiters
    rainbow-delimiters smartparens

    # Evil
    avy
    evil
    evil-surround
    evil-indent-textobject
    evil-cleverparens
    undo-tree

    # Git
    magit
    git-timemachine

    # LaTeX
    auctex
    cdlatex
    company-math

    auto-compile
    flycheck

    markdown-mode
    pkgs.ledger
    yaml-mode

    # Haskell
    haskell-mode
    flycheck-haskell
    company-ghci  # provide completions from inferior ghci
    dhall-mode

    # Org
    org org-ref

    # Rust
    rust-mode cargo flycheck-rust

    # Mail
    notmuch messages-are-flowing

    # Nix
    pkgs.nix nix-buffer

    # Maxima
    pkgs.maxima

    # Idris
    idris-mode

    fish-mode
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
