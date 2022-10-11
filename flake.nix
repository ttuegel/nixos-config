{
  inputs.nixpkgs.url = "github:ttuegel/nixpkgs?ref=hosts/main";
  inputs.secrets = {
    url = "git+ssh://gitolite@zeus/ttuegel/nixos-secrets?ref=main";
    flake = false;
  };
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";

  outputs = { self, nixpkgs, secrets, nixpkgs-stable }: {
    nixosConfigurations = {
      pollux = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/pollux/configuration.nix ];
        specialArgs = { inherit secrets; };
      };
      zeus = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/zeus/configuration.nix ];
        specialArgs = { inherit secrets; };
      };
    };
  };
}
