{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../../home/helix.nix
    ../../home/zellij.nix
    ../../home/zsh.nix
  ];

  programs = {
    bat.enable = true;
    fzf.enable = true;
    git.enable = true;
    home-manager.enable = true;
    htop.enable = true;
    lazygit.enable = true;
    ranger.enable = true;
    ripgrep.enable = true;
    yazi.enable = true;
  };

  home.packages = with pkgs; [
    e2fsprogs
    zip
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };
}
