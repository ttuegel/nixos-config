{ pkgs, lib, ... }:

let
  inherit (pkgs) vscode-extensions vscode-utils vscode-with-extensions;

  vscode-pull-request-github = vscode-utils.extensionFromVscodeMarketplace {
    name = "vscode-pull-request-github";
    publisher = "github";
    version = "0.21.4";
    sha256 = "1pr9q54qlaa4yrdbwyvx351b742aqmrgw9b5vq2m6sir58czprvd";
  };

  gitlens = vscode-utils.extensionFromVscodeMarketplace {
    name = "gitlens";
    publisher = "eamodio";
    version = "11.0.6";
    sha256 = "0qlaq7hn3m73rx9bmbzz3rc7khg0kw948z2j4rd8gdmmryy217yw";
  };

  nix-env-selector = vscode-utils.extensionFromVscodeMarketplace {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "0.1.2";
    sha256 = "1n5ilw1k29km9b0yzfd32m8gvwa2xhh6156d4dys6l8sbfpp2cv9";
  };

  editorconfig = vscode-utils.extensionFromVscodeMarketplace {
    name = "editorconfig";
    publisher = "editorconfig";
    version = "0.16.4";
    sha256 = "0fa4h9hk1xq6j3zfxvf483sbb4bd17fjl5cdm3rll7z9kaigdqwg";
  };

  rewrap = vscode-utils.extensionFromVscodeMarketplace {
    name = "rewrap";
    publisher = "stkb";
    version = "1.13.0";
    sha256 = "18h42vfxngix8x22nqslvnzwfvfq5kl35xs6fldi211dzwhw905j";
  };

  vscode = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions;
      [
        editorconfig
        rewrap
        bbenoist.Nix
        dhall.dhall-lang
        gitlens
        haskell.haskell justusadam.language-haskell
        ms-azuretools.vscode-docker
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
