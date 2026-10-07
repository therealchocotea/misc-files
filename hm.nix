{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];
  home-manager.users.anon = {
    home.stateVersion = "26.05";
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "chocotea";
          email = "nocturnallurker@posteo.net";
        };
        init.defaultBranch = "master";
      };
    };

    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.magit
        epkgs.use-package
        epkgs.sly
        epkgs.forth-mode
        epkgs.web-mode
        epkgs.json-mode
        epkgs.format-all
        epkgs.zenburn-theme
      ];
      extraConfig = ''
        	(load-theme 'zenburn t)
        	(scroll-bar-mode 0)
        	(tool-bar-mode 0)
        	(show-paren-mode 2)
        	(electric-pair-mode 1)


        	(setq-default tab-width 4
                      truncate-lines t
                      fill-column 72
                      indent-tabs-mode nil)

        (setq show-paren-style 'parenthesis
              global-hl-line-sticky-flag t
              display-line-numbers-type 'relative
              electric-indent-mode nil
              make-backup-files nil
              history-length 2000
              whitespace-line-column 72)

        (global-display-line-numbers-mode t)
        	'';
    };

  };
}
