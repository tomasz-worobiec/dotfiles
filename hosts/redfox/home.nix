{
  pkgs,
  ...
}:
let
  username = "tom";
in
{
  imports = [
    ../../home/neovim.nix
    ../../home/tmux.nix
    ../../home/zsh.nix
    ../../home/desktop-env/hyprland.nix
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs = {
    alacritty.enable = true;
    bat.enable = true;
    chromium = {
      enable = true;
      package = pkgs.brave;
    };
    firefox.enable = true;
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
