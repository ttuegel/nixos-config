{ config, secrets, ... }:

{
  services.openvpn.servers = {
    pritunl = {
      autoStart = false;
      updateResolvConf = true;
      config = "${secrets}/mercury/pritunl-thomas.ovpn";
    };
  };
}
