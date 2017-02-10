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
        ''${name} = (${"$" + name} $NIX_PROFILES^${esShowList value})'';
      exportVariables = mapAttrsToList setRelativeVar vars;
    in
      concatStringsSep "\n" exportVariables;
in

{
  environment.profiles = mkForce [
    "/nix/var/nix/profiles/default"
    "/run/current-system/sw"
  ];

  environment.etc."esrc".text = ''
    # /etc/esrc: DO NOT EDIT -- this file is generated automatically

    NIX_USER_PROFILE_DIR = /nix/var/nix/profiles/per-user/^$USER
    NIX_PROFILES = ( $NIX_USER_PROFILE_DIR/profile ${esShowList cfg.profiles} )

    path=

    ${absoluteEnvVars}

    ${relativeEnvVars}

    path = ( ${config.security.wrapperDir} $path )

    if { test $USER '!=' root -o '!' -w /nix/var/nix/db } { NIX_REMOTE = daemon }
  '';

  environment.systemPackages = [ pkgs.es ];
}
