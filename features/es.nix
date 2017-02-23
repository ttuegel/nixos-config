{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.environment;

  esVarName =
    let
      upperChars = ["_"] ++ lib.upperChars;
      lowerChars = ["-"] ++ lib.lowerChars;
    in
      lib.replaceChars upperChars lowerChars;

  esSettors = unixName:
    let
      esName = esVarName unixName;
    in ''
      set-${unixName} = @ {
        local ( set-${esName} = )
          ${esName} = <={ %fsplit ':' $* }
        result $*
      }

      set-${esName} = @ {
        local ( set-${unixName} = )
          ${unixName} = <={ %flatten ':' $* }
        result $*
      }
    '';

  escQuote = builtins.replaceStrings ["'"] ["''"];

  esList = as:
      "(" + concatMapStringsSep " " (a: "'" + escQuote a + "'") as + ")";

  absoluteEnvVars =
    let
      vars = mapAttrs (n: toList) cfg.variables;
      setAbsoluteVar = unixName: value: ''
        ${esSettors unixName}
        ${esVarName unixName} = ${esList (concatMap (splitString ":") value)};
      '';
      exportVariables = mapAttrsToList setAbsoluteVar vars;
    in
      concatStringsSep "\n" exportVariables;

  relativeEnvVars =
    let
      vars = mapAttrs (n: toList) cfg.profileRelativeEnvVars;
      setRelativeVar = unixName: value: ''
        ${esSettors unixName}
        ${esVarName unixName} = $nix-profiles^${esList value}
      '';
      exportVariables = mapAttrsToList setRelativeVar vars;
    in
      concatStringsSep "\n" exportVariables;
in

{
  nixpkgs.config.packageOverrides = super: let self = super.pkgs; in {
    es = super.es.overrideDerivation (args: {
      patches =
        let startupFiles = self.fetchurl {
              url = "https://github.com/ttuegel/es-shell/commit/c653d549db285abeaf2a11d2b6c0abc09ec20959.patch";
              sha256 = "1zi1jfwnza30ly3y74crr3pqnz0j089gky1vk931q003mrx1nfa3";
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

    set-nix-profiles = @{
      local ( set-NIX_PROFILES = )
        NIX_PROFILES = $^*
      result $*
    }

    set-NIX_PROFILES = @{
      local ( set-nix-profiles = )
        nix-profiles = <={ %fsplit ' ' $* }
      result $*
    }

    nix-profiles = ( $NIX_USER_PROFILE_DIR/profile ${esList cfg.profiles} )

    ${absoluteEnvVars}

    ${relativeEnvVars}

    path = ( ${config.security.wrapperDir} $path )

    if { test $USER '!=' root -o '!' -w /nix/var/nix/db } { NIX_REMOTE = daemon }

    }
  '';

  environment.systemPackages = [ pkgs.es ];
}
