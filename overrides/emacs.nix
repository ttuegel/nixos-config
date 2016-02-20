self: super:

let pkgs = self; in

{
  ttuegel = {
    emacs = pkgs.emacsWithPackages
      (epkgs: with epkgs; [
        ace-jump-mode
        auctex
        company
        company-ghc
        diminish
        evil
        evil-indent-textobject
        evil-leader
        evil-surround
        fill-column-indicator
        flycheck
        ghc
        git-auto-commit-mode
        git-timemachine
        melpaPackages.haskell-mode
        helm
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
