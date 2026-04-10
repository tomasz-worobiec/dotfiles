{
  pkgs,
  colorScheme,
  ...
}:
{
  imports = [
    ../minimal/home.nix
    ../../home/desktop-env/hyprland.nix
  ];

  programs = {
    alacritty.enable = true;
    chromium = {
      enable = true;
      package = pkgs.brave;
    };
    firefox.enable = true;
  };

  home.packages = with pkgs; [
    baobab
    gimp
    kdePackages.dolphin
    kdePackages.okular
    spotify
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
      helix.enable = true;
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
}
