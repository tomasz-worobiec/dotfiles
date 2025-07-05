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
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
  };

  home.stateVersion = "25.05";
}
