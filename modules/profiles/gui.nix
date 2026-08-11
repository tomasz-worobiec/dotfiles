{
  config,
  ...
}:
{
  flake.profiles.gui.nixos =
    { pkgs, ... }:
    {
      imports = with config.flake; [
        profiles.minimal.nixos
        nixosModules.stylix
        nixosModules.niri
      ];

      fonts.packages = with pkgs; [
        nerd-fonts._0xproto
      ];

      stylix = {
        enable = true;
        autoEnable = false;
        polarity = "dark";

        targets = {
          chromium.enable = true;
        };
      };

      networking = {
        firewall = {
          allowedTCPPorts = [
            57621 # spotify: Sync with devices in the same network
            5353 # spotify: Allow discovery of Google Cast devices
          ];
        };
      };

      services.pipewire.pulse.enable = true;

      environment.sessionVariables = {
        # Force Electron to use Wayland
        NIXOS_OZONE_WL = "1";
      };
    };

  flake.profiles.gui.home =
    { pkgs, ... }:
    {
      imports = with config.flake; [
        profiles.minimal.home
        homeModules.stylix
        homeModules.niri
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
    };
}
