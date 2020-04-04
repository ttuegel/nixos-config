{ config, pkgs, ... }:

let
  inherit (pkgs) emacsPackages;

  emacs = emacsPackages.emacsWithPackages (epkgs: with epkgs; [
    use-package

    # Interface
    bind-key
    company
    ivy counsel swiper
    projectile counsel-projectile  # project management
    ripgrep  # search
    visual-fill-column
    which-key  # display keybindings after incomplete command
    winum eyebrowse # window management

    # Themes
    diminish
    spaceline # modeline beautification
    solarized-theme

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
    git-auto-commit-mode
    git-timemachine
    magit

    # LaTeX
    auctex
    cdlatex
    company-math

    auto-compile
    direnv
    flycheck

    markdown-mode
    pkgs.ledger
    yaml-mode

    # Haskell
    haskell-mode
    flycheck-haskell
    company-ghci  # provide completions from inferior ghci
    dhall-mode
    hindent
    intero
    dante

    lsp-mode lsp-ui lsp-haskell lsp-java lsp-treemacs
    yasnippet

    # Org
    org

    # Rust
    rust-mode cargo flycheck-rust

    # Mail
    notmuch messages-are-flowing

    # Nix
    nix-mode nix-buffer

    # Maxima
    pkgs.maxima

    # Idris
    idris-mode

    editorconfig
    fish-mode
    w3m

    # Ledger
    ledger-mode flycheck-ledger evil-ledger

    groovy-mode
    scala-mode
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
