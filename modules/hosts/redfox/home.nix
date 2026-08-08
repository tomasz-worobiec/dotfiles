{
  config,
  ...
}:
{
  flake.homeModules.redfoxHome =
    { pkgs, ... }:
    {
      imports = with config.flake; [
        profiles.gui.home
      ];

      wayland.windowManager.hyprland = {
        settings.monitor = "eDP-1,1920x1080@60, 0x0, 1.25";
      };

      home.stateVersion = "25.05";
    };
}
