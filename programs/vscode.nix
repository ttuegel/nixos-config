{ pkgs, lib, ... }:

let
  inherit (pkgs) vscode-extensions vscode-utils vscode-with-extensions;

  vscode-pull-request-github = vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-pull-request-github";
    publisher = "github";
    version = "0.21.4";
    sha256 = "sha256:1pr9q54qlaa4yrdbwyvx351b742aqmrgw9b5vq2m6sir58czprvd";
  };

  gitlens = vscode-utils.extensionFromVscodeMarketplace {
    name = "gitlens";
    publisher = "eamodio";
    version = "11.0.6";
    sha256 = "sha256:0qlaq7hn3m73rx9bmbzz3rc7khg0kw948z2j4rd8gdmmryy217yw";
  };

  nix-env-selector = vscode-utils.extensionFromVscodeMarketplace {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "0.1.2";
    sha256 = "sha256:1n5ilw1k29km9b0yzfd32m8gvwa2xhh6156d4dys6l8sbfpp2cv9";
  };

  vscode = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions;
      [
        bbenoist.Nix
        dhall.dhall-lang
        gitlens
        haskell.haskell justusadam.language-haskell
        ms-azuretools.vscode-docker
        ms-python.python
        ms-vscode.cpptools
        ms-vscode-remote.remote-ssh
        nix-env-selector
        vscode-pull-request-github
      ];
  };
in
{
  environment.systemPackages = [ vscode ];
}
