{ ... }:

{
  services.openvpn.servers = {
    pritunl = {
      autoStart = false;
      updateResolvConf = true;
      config = builtins.readFile ../secrets/mercury/pritunl-thomas.ovpn;
    };
  };
}
