self: super:

let inherit (self) fetchgit; in

let
  lock =
    builtins.fromJSON (builtins.readFile ./nixpkgs-channels.json);
  bootstrap = fetchgit {
    inherit (lock) url rev sha256 fetchSubmodules;
  };
in
  import bootstrap {}
