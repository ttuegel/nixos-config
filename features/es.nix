{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.environment;

  esShowList = as:
    let
      escQuote = builtins.replaceStrings ["'"] ["''"];
    in
      "(" + concatMapStringsSep " " (a: "'" + escQuote a + "'") as + ")";

  absoluteEnvVars =
    let
      vars = mapAttrs (n: toList) cfg.variables;
      setAbsoluteVar = name: value: ''${name} = ${esShowList value}'';
      exportVariables = mapAttrsToList setAbsoluteVar vars;
    in
      concatStringsSep "\n" exportVariables;

  relativeEnvVars =
    let
      vars = mapAttrs (n: toList) cfg.profileRelativeEnvVars;
      setRelativeVar = name: value:
        ''${name} = $NIX_PROFILES^${esShowList value}'';
      exportVariables = mapAttrsToList setRelativeVar vars;
    in
      concatStringsSep "\n" exportVariables;
in

{
  nixpkgs.config.packageOverrides = super: let self = super.pkgs; in {
    es = super.es.overrideDerivation (args: {
      patches =
        let startupFiles = self.fetchurl {
              url = "https://github.com/ttuegel/es-shell/commit/7daa5f5f0cc2b6b9833c1586297c483dc95e7f8e.patch";
              sha256 = "07bjfiafz0991w2sxf0n76mg4kp2qwzd3871234wbjrcr8nj2302";
            };
        in (args.patches or []) ++ [ startupFiles ];
    });
  };

  environment.profiles = mkForce [
    "/nix/var/nix/profiles/default"
    "/run/current-system/sw"
  ];

  environment.etc."esenv".text = ''
    # /etc/esenv: DO NOT EDIT -- this file is generated automatically

    if { ~ $--etc-esenv-loaded () } {

    --etc-esenv-loaded = 1

    NIX_USER_PROFILE_DIR = /nix/var/nix/profiles/per-user/^$USER
    NIX_PROFILES = ( $NIX_USER_PROFILE_DIR/profile ${esShowList cfg.profiles} )

    ${absoluteEnvVars}

    ${relativeEnvVars}

    path = ( ${config.security.wrapperDir} $path )

    if { test $USER '!=' root -o '!' -w /nix/var/nix/db } { NIX_REMOTE = daemon }

    }
  '';

  environment.systemPackages = [ pkgs.es ];
}
