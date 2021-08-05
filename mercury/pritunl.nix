{ ... }:

{
  services.openvpn.servers = {
    pritunl = {
        autoStart = false;
        updateResolvConf = true;
        config = builtins.readFile ../secrets/mercury/pritunl-thomas.ovpn;
    };
  };
  security.pki.certificateFiles = [ ../secrets/mercury/internal.mercury.com.ca.crt ];
}
