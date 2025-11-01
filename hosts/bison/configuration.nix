{
  pkgs-unstable,
  ...
}:
{
  imports = [
    ../../profiles/gui/system.nix
    ./hardware-configuration.nix
  ];

  hardware = {
    bluetooth = {
      enable = true;
      # On 25.05 package there is a bug which causes:
      # * bt devices to not connect automatically after reboot and
      # * keyboard input lag when mouse and keyboard are connected at the same time.
      # Temporary switch to unstable bluez. Restore after new release.
      package = pkgs-unstable.bluez;
    };

    graphics = {
      enable = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
    };
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
