{ config, pkgs, ... }:

let

  gnupg = pkgs.gnupg21;

  autostartGpgAgent = pkgs.writeTextFile {
    name = "autostart-gpg-agent";
    destination = "/etc/xdg/autostart/gpg-agent.desktop";
    text = ''
      [Desktop Entry]
      Name=GPG Agent
      Type=Application
      Exec=${gnupg}/bin/gpg-agent --daemon
    '';
  };

in

{
  programs.ssh.startAgent = false;

  environment.systemPackages = [ autostartGpgAgent pkgs.pinentry_qt5 ];

  environment.extraInit = ''
    if [ -n "$TTY" -o -n "$DISPLAY" ]; then
        ${gnupg}/bin/gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    fi

    if [ -z "$SSH_AUTH_SOCK" ]; then
        export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
    fi
  '';
}
