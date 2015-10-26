{ config, pkgs, ... }:

{
  programs.ssh.startAgent = false;

  environment.etc."xdg/autostart/gpg-agent.desktop".source
    = pkgs.makeDesktopItem {
        name = "gpg-agent";
        exec = "${pkgs.gnupg}/bin/gpg-agent --enable-ssh-support --pinentry-program ${pkgs.pinentry_qt}/bin/pinentry-qt4 --daemon";
      };

  environment.extraInit = ''
    if [ -n "$TTY" -o -n "$DISPLAY" ]; then
        ${pkgs.gnupg21}/bin/gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    fi

    if [ -z "$SSH_AUTH_SOCK" ]; then
        export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
    fi
  '';
}
