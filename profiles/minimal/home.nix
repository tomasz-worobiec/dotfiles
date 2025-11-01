{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../../home/neovim.nix
    ../../home/tmux.nix
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
  };

  home.packages = with pkgs; [
    nil
    e2fsprogs
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };
}
