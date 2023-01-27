{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.secrets = {
    url = "git+ssh://gitolite@zeus/ttuegel/nixos-secrets?ref=main";
    flake = false;
  };
  inputs.nixpkgs-zeus.url = "github:NixOS/nixpkgs/nixos-22.11";
  inputs.nixpkgs-olympus.url = "github:NixOS/nixpkgs/nixos-22.11";
  inputs.emacs-config.url = "git+file:///home/ttuegel/emacs-config";
  inputs.agenix-cli.url = "github:cole-h/agenix-cli";
  inputs.agenix.url = "github:ryantm/agenix";

  outputs = inputs@{ self, ... }: {
    nixosConfigurations = {

      # Workstations

      dioscuri = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/dioscuri/configuration.nix ];
        specialArgs = { inherit (inputs) secrets; };
      };

      hermes = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/hermes/configuration.nix ];
        specialArgs = { inherit (inputs) emacs-config secrets; };
      };

      hercules = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/hercules/configuration.nix ];
        specialArgs = { inherit (inputs) emacs-config secrets; };
      };

      pollux = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/pollux/configuration.nix ];
        specialArgs = { inherit (inputs) agenix-cli emacs-config secrets; };
      };

      # Special purpose

      micro = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/micro/configuration.nix ];
        specialArgs = { inherit (inputs) emacs-config secrets; };
      };

      rescue = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/rescue/configuration.nix ];
        specialArgs = { inherit (inputs) emacs-config secrets; };
      };

      # Servers

      olympus = inputs.nixpkgs-olympus.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/olympus/configuration.nix
          inputs.agenix.nixosModule
        ];
        specialArgs = { inherit (inputs) emacs-config secrets; };
      };

      zeus = inputs.nixpkgs-zeus.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/zeus/configuration.nix
          inputs.agenix.nixosModule
        ];
        specialArgs = { inherit (inputs) agenix-cli secrets; };
      };

    };
  };
}
