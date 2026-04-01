{
  pkgs,
  colorScheme,
  ...
}:
{
  imports = [
    ../minimal/system.nix
    ../../system/greetd.nix
  ];

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${colorScheme}";
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
}
