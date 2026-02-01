{
  pkgs,
  lib,
  ...
}:
{
  services.displayManager.sddm = {
    enable = true;
    settings.General.DisplayServer = "wayland";
    wayland = {
      enable = true;
      compositor = "kwin";
    };
  };
}

