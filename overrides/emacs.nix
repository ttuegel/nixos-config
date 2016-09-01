self: super:

let pkgs = self; in

{
  emacs = super.emacs.override { withGTK2 = false; withGTK3 = true; };
  emacsPackagesNg = super.emacsPackagesNgGen self.emacs;
  emacsWithPackages = self.emacsPackagesNg.emacsWithPackages;

  ttuegel = {
    emacs = self.emacsWithPackages
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
        intero
        pkgs.ledger
        magit
        markdown-mode
        monokai-theme
        org-plus-contrib
        rainbow-delimiters
        undo-tree
        use-package
        yaml-mode
        yasnippet
      ]);
  };
}
