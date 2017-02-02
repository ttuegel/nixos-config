{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.environment;

  esToList = as:
    let
      escQuote = builtins.replaceStrings ["'"] ["''"];
    in
      "(" + concatMapStringsSep " " (a: "'" + escQuote a + "'") as + ")";

  absoluteEnvVars =
    let
      vars = mapAttrs (n: toList) cfg.variables;
      setAbsoluteVar = name: value: ''${name} = ${esToList value}'';
      exportVariables = mapAttrsToList setAbsoluteVar vars;
    in
      concatStringsSep "\n" exportVariables;

  relativeEnvVars =
    let
      vars = mapAttrs (n: toList) cfg.profileRelativeEnvVars;
      setRelativeVar = name: value: ''${name} = (${"$" + name} $NIX_PROFILES^${esToList value})'';
      exportVariables = mapAttrsToList setRelativeVar vars;
    in
      concatStringsSep "\n" exportVariables;
in

{
  environment.profiles = mkForce [
    "/run/current-system/sw"
    "/nix/var/nix/profiles/default"
  ];

  environment.etc."esrc".text = ''
    # /etc/esrc: DO NOT EDIT -- this file is generated automatically

    NIX_USER_PROFILE_DIR = /nix/var/nix/profiles/per-user/^$USER
    NIX_PROFILES = ${esToList cfg.profiles}

    ${absoluteEnvVars}

    ${relativeEnvVars}

    PATH = ( ${config.security.wrapperDir} $PATH )

    if { test $USER '!=' root -o '!' -w /nix/var/nix/db } { NIX_REMOTE = daemon }
  '';

  environment.systemPackages = [ pkgs.es ];
}
