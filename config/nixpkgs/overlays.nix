let
  emacs-overlay = import (import ./nix/sources.nix)."emacs-overlay";
in
[
  emacs-overlay
]
