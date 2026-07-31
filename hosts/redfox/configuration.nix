{
  pkgs,
  pkgs-unstable,
  colorScheme,
  hostname,
  ...
}:
{
  imports = [
    ../../profiles/gui/system.nix
    ./hardware-configuration.nix
    ../../system/greetd.nix
  ];

  hardware.bluetooth = {
    enable = true;
    # On 25.05 package there is a bug which causes:
    # * bt devices to not connect automatically after reboot and
    # * keyboard input lag when mouse and keyboard are connected at the same time.
    # Temporary switch to unstable bluez. Restore after new release.
    package = pkgs-unstable.bluez;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.05";
}
