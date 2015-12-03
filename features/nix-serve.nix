{ ... }:

{
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/lib/nix-serve/tuegel.mooo.com-1.key";
  };
}
