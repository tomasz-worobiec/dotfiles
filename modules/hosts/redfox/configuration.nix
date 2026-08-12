{
  config,
  ...
}:
{
  flake.nixosModules.redfoxConfiguration =
    { pkgs, ... }:
    {
      imports = with config.flake; [
        profiles.gui.nixos
        nixosModules.redfoxHardware
        # nixosModules.redfoxDisk
      ];

      hardware.graphics.enable = true;

      hardware.bluetooth = {
        enable = true;
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      system.stateVersion = "25.05";
    };
}
