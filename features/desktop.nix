{ config, pkgs, ... }:

{
  imports = [
    ../features/kde5.nix
  ];

  hardware.enableAllFirmware = true;

  hardware.pulseaudio.enable = true;

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ table table-others ];
  };

  services.colord.enable = true;
  services.samba.enable = true;

  programs.ssh.startAgent = false;
  environment.extraInit = ''
    # Start gpg-agent (if necessary) in every local shell.
    if whence gpg-agent >/dev/null 2>&1 && [ -z "$SSH_CONNECTION" ]; then
        gpg-agent --daemon >/dev/null 2>&1
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
    fi
  '';
}
