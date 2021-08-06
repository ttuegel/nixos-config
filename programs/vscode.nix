{ pkgs, lib, ... }:

let
  inherit (pkgs) vscode-extensions vscode-utils vscode-with-extensions;

  gitlens = vscode-utils.extensionFromVscodeMarketplace {
    name = "gitlens";
    publisher = "eamodio";
    version = "11.6.0";
    sha256 = "sha256:0lhrw24ilncdczh90jnjx71ld3b626xpk8b9qmwgzzhby89qs417";
  };

  nix-env-selector = vscode-utils.extensionFromVscodeMarketplace {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "1.0.7";
    sha256 = "sha256:0mralimyzhyp4x9q98x3ck64ifbjqdp8cxcami7clvdvkmf8hxhf";
  };

  editorconfig = vscode-utils.extensionFromVscodeMarketplace {
    name = "editorconfig";
    publisher = "editorconfig";
    version = "0.16.4";
    sha256 = "sha256:0fa4h9hk1xq6j3zfxvf483sbb4bd17fjl5cdm3rll7z9kaigdqwg";
  };

  rewrap = vscode-utils.extensionFromVscodeMarketplace {
    name = "rewrap";
    publisher = "stkb";
    version = "1.14.0";
    sha256 = "sha256:0phffzqv1nmwsgcx6abgzbzw95zc0zlnhsjv2grs5mcsgrghl759";
  };

  vscode = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions;
      [
        editorconfig
        rewrap
        gitlens
        nix-env-selector
        bbenoist.nix
        dhall.dhall-lang
        haskell.haskell justusadam.language-haskell
        ms-azuretools.vscode-docker
        ms-vscode.cpptools
        ms-vscode-remote.remote-ssh
      ];
  };
in
{
  environment.systemPackages = [ vscode ];
}
