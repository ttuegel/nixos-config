{ config, pkgs, ... }:

{
  programs.ssh.startAgent = false;
  systemd.user.services = {
    gpg-agent = {
      description = "Secret key management for GnuPG";
      enable = true;
      serviceConfig = {
        Type = "forking";
        ExecStart = "${pkgs.gnupg21}/bin/gpg-agent --enable-ssh-support --daemon";
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
