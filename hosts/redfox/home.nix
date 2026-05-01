{
  ...
}:
{
  imports = [
    ../../profiles/gui/home.nix
  ];

  wayland.windowManager.hyprland = {
    settings.monitor = "eDP-1,1920x1080@60, 0x0, 1.25";
  };

  home.stateVersion = "25.05";
}
