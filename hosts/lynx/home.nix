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

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs = {
    bat.enable = true;
    fzf.enable = true;
    git.enable = true;
    home-manager.enable = true;
    htop.enable = true;
    lazygit.enable = true;
    ripgrep.enable = true;
  };

  home.packages = with pkgs; [
    nil
  ];

  home.stateVersion = "25.05";
}
