{
  pkgs,
  ...
}:
let
  username = "tom";
in
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "25.05";
}
