{
  config,
  ...
}:
{
  flake.nixosModules.lynxConfiguration =
    { pkgs, ... }:
    {
      imports = with config.flake; [
        profiles.minimal.nixos
        nixosModules.lynxHardware
        nixosModules.lynxDisk
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      system.stateVersion = "25.05";
    };
}
