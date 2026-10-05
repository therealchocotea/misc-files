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

    programs.vim = {
      enable = true;
      defaultEditor = true;
      packageConfigurable = pkgs.vim-full;
      extraConfig = ''
        set mouse=a
        set visualbell
        set errorbells
        set cindent
        set spell
        set textwidth=72
        set confirm
        set number
        set linebreak
        set snowbreak=$
        set showmatch
        set hlsearch
        set autoindent
        set shiftwidth=2
        set smartindent
        set smarttab
        set softtabstop=2
        set ruler
        set undolevels=1000
        set backspace=indent,eol,start
      '';
    };

  };
}
