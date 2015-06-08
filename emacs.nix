{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.emacs_custom ];
  systemd.user.services.emacs = {
    description = "Emacs Daemon";
    enable = true;
    environment.GTK_DATA_PREFIX = config.system.path;
    environment.GTK_PATH = "${config.system.path}/lib/gtk-2.0:${config.system.path}/lib/gtk-3.0";
    environment.SSH_AUTH_SOCK = "%h/.gnupg/S.gpg-agent.ssh";
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.emacs_custom}/bin/emacs --daemon";
      ExecStop = "${pkgs.emacs_custom}/bin/emacsclient --eval (kill-emacs)";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };
}
