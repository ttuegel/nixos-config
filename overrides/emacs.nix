self: super:

let pkgs = self; in

{
  ttuegel = {
    emacs = pkgs.emacsWithPackages
      (epkgs: with epkgs; [
        auctex
        avy
        company
        diminish
        evil
        evil-indent-textobject
        evil-leader
        evil-surround
        fill-column-indicator
        flycheck
        git-auto-commit-mode
        git-timemachine
        haskell-mode
        helm
        hindent
        idris-mode
        pkgs.ledger
        magit
        markdown-mode
        monokai-theme
        org-plus-contrib
        rainbow-delimiters
        undo-tree
        yasnippet
      ]);
  };
}
