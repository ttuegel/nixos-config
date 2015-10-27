{ config, pkgs, ... }:

let

  startGpgAgent = pkgs.writeScript "start-gpg-agent"
    ''
        #!/bin/sh
        . ${config.system.build.setEnvironment}
        ${pkgs.gnupg21}/bin/gpg-agent \
            --enable-ssh-support \
            --pinentry-program ${pkgs.pinentry_qt}/bin/pinentry-qt4 \
            --daemon
    '';

in

{
  programs.ssh.startAgent = false;
  systemd.user.services = {
    gpg-agent = {
      description = "Secret key management for GnuPG";
      enable = true;
      serviceConfig = {
        Type = "forking";
        ExecStart = "${startGpgAgent}";
        ExecStop = "${pkgs.procps}/bin/pkill -u %u gpg-agent";
        Restart = "always";
      };
      wantedBy = [ "default.target" ];
    };
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
