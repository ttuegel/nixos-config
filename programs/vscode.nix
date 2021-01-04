{ pkgs, ... }:

let
  inherit (pkgs) vscode-extensions vscode-utils vscode-with-extensions;
  mkExtension = vscode-utils.extensionFromVscodeMarketplace;
  vscodeExtensions = map mkExtension (import ./vscode-exts.nix).extensions;
  vscode = vscode-with-extensions.override { inherit vscodeExtensions; };
in
{
  environment.systemPackages = [ vscode ];
}
