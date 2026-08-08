{
  config,
  ...
}:
{
  flake.nixosModules.bisonConfiguration =
    { pkgs, ... }:
    {
      imports = with config.flake; [
        profiles.gui.nixos
        nixosModules.bisonHardware
        nixosModules.bisonDisk
      ];

      hardware = {
        bluetooth = {
          enable = true;
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
      services.xserver.videoDrivers = [ "nvidia" ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      system.stateVersion = "25.05";
    };
}
