self: super:

{

  dfPackages =
    let
      inherit (self) pkgs pkgsi686Linux;
      callPackage = pkgs.newScope dfPackages;
      callPackage_i686 = pkgsi686Linux.newScope dfPackages;

      dfPackages = rec {
        dwarf-fortress-original = callPackage_i686 ./game.nix { };

        dfhack = callPackage_i686 ./dfhack {
          inherit (pkgsi686Linux.perlPackages) XMLLibXML XMLLibXSLT;
          protobuf = with pkgsi686Linux; protobuf.override {
            stdenv = overrideInStdenv stdenv [ useOldCXXAbi ];
          };
        };

        dwarf-fortress-unfuck = callPackage_i686 ./unfuck { };

        dwarf-fortress = callPackage ./wrapper {
          themes = {
            "phoebus" = phoebus-theme;
            "cla" = cla-theme;
            "gemset" = gemset-theme;
          };
        };

        dwarf-therapist-original = pkgs.qt5.callPackage ./dwarf-therapist {
          texlive = pkgs.texlive.combine {
            inherit (pkgs.texlive)
              scheme-basic float caption wrapfig
              adjmulticol sidecap preprint enumitem;
          };
        };

        dwarf-therapist = callPackage ./dwarf-therapist/wrapper.nix { };

        phoebus-theme = callPackage ./themes/phoebus.nix { };

        cla-theme = callPackage ./themes/cla.nix { };

        gemset-theme = callPackage ./themes/gemset.nix { };
      };
    in dfPackages;

  df = self.dfPackages.dwarf-fortress.override {
    theme = "gemset";
    enableDFHack = true;
  };

}
