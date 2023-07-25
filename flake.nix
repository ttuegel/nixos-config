{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.secrets = {
    #url = "git+ssh://gitolite@zeus/ttuegel/nixos-secrets?ref=main";
    url = "git+file:./secrets";
    flake = false;
  };
  inputs.nixpkgs-zeus.url = "github:NixOS/nixpkgs/nixos-23.05";
  inputs.nixpkgs-olympus.url = "github:NixOS/nixpkgs/nixos-23.05";
  inputs.agenix-cli.url = "github:cole-h/agenix-cli";
  inputs.agenix.url = "github:ryantm/agenix";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware";

  outputs = inputs@{ self, flake-utils, ... }: {
    nixosConfigurations = {

      # Workstations

      bingo = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/bingo/configuration.nix ];
        specialArgs = { inherit (inputs) secrets; };
      };

      hercules = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/hercules/configuration.nix ];
        specialArgs = { inherit (inputs) secrets; };
      };

      radley = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/radley/configuration.nix ];
        specialArgs = { inherit (inputs) agenix-cli secrets; };
      };

      bandit = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/bandit/configuration.nix
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
        specialArgs = { inherit (inputs) agenix-cli secrets; };
      };

      # Special purpose

      micro = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/micro/configuration.nix ];
        specialArgs = { inherit (inputs) secrets; };
      };

      rescue = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/rescue/configuration.nix ];
      };

      # Servers

      olympus = inputs.nixpkgs-olympus.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/olympus/configuration.nix
          inputs.agenix.nixosModules.default
        ];
        specialArgs = { inherit (inputs) secrets; };
      };

      zeus = inputs.nixpkgs-zeus.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/zeus/configuration.nix
          inputs.agenix.nixosModules.default
        ];
        specialArgs = { inherit (inputs) agenix-cli secrets; };
      };

    };
  }
  // (flake-utils.lib.eachDefaultSystem (system: {
      devShells.default =
        let pkgs = inputs.nixpkgs.legacyPackages.${system}; in
        pkgs.mkShell {
          packages = [ pkgs.vultr-cli ];
        };
    })
  );
}
