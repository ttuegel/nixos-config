{ config, pkgs, ... }:

let

  emacs = pkgs.emacsWithPackages
    (with pkgs.emacsPackages; with pkgs.emacsPackagesNg; [
      ace-jump-mode
      auctex
      company
      #company-ghc
      diminish
      evil
      #evil-indent-textobject
      evil-leader
      #evil-surround
      flycheck
      #ghc-mod
      git-auto-commit-mode
      git-timemachine
      haskell-mode
      helm
      pkgs.ledger
      magit
      markdown-mode
      monokai-theme
      org-plus-contrib
      rainbow-delimiters
      undo-tree
      use-package
    ]);

  startEmacsServer = pkgs.writeScript "start-emacs-server"
    ''
        #!/bin/sh
        . ${config.system.build.setEnvironment}
        ${emacs}/bin/emacs --daemon
    '';

in

{
  environment.systemPackages = [ emacs ];
  systemd.user.services.emacs = {
    description = "Emacs Daemon";
    enable = true;
    environment.SSH_AUTH_SOCK = "%h/.gnupg/S.gpg-agent.ssh";
    serviceConfig = {
      Type = "forking";
      ExecStart = "${startEmacsServer}";
      ExecStop = "${emacs}/bin/emacsclient --eval (kill-emacs)";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };
}
