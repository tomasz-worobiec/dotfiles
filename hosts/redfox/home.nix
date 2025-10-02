{
  pkgs,
  colorScheme,
  username,
  ...
}:
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
    ranger.enable = true;
    ripgrep.enable = true;
  };

  home.packages = with pkgs; [
    baobab
    nil
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${colorScheme}";

    polarity = "dark";

    targets = {
      alacritty.enable = true;
      fontconfig.enable = true;
      gtk.enable = true;
      rofi.enable = true;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    fonts = {
      serif = {
        package = pkgs.nerd-fonts._0xproto;
        name = " FiraMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts._0xproto;
        name = " FiraMono Nerd Font";
      };
      emoji = {
        package = pkgs.nerd-fonts._0xproto;
        name = " FiraMono Nerd Font";
      };
      monospace = {
        package = pkgs.nerd-fonts._0xproto;
        name = "0xProto Nerd Font Mono";
      };
    };
  };

  home.stateVersion = "25.05";
}
