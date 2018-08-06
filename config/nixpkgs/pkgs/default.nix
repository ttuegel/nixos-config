self: super: with self;

{
  feast = callPackage ./feast {
    openblas = openblasCompat;
  };

  repos =
    let
      lock = self.lib.importJSON ./repos.lock.json;
      src = self.fetchFromGitHub {
        owner = "ttuegel";
        repo = "repos";
        inherit (lock) rev sha256;
      };
    in
      import src;

  uiucthesis2014 = callPackage ./uiucthesis2014.nix {};
}
