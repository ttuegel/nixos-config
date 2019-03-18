{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (texlive.combine {
      inherit (texlive)
        scheme-full
        collection-mathscience
        collection-publishers
        ;
      uiucthesis2014.pkgs = [
        (uiucthesis2014 // { pname = "uiucthesis2014"; tlType = "run"; })
      ];
    })
    biber
    bibutils
  ];
}
