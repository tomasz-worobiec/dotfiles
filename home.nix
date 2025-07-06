{
  pkgs,
  ...
}:
let
  username = "tom";
in
{
  imports = [
    ./home/neovim.nix
    ./home/tmux.nix
    ./home/zsh.nix
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs = {
    bat.enable = true;
    home-manager.enable = true;
    lazygit.enable = true;
  };

  home.stateVersion = "25.05";
}
