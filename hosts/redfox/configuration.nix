{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../system/greetd.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    lshw
  ];

  programs.zsh.enable = true;

  environment.sessionVariables = {
    # Force Electron to use Wayland
    NIXOS_OZONE_WL = "1";
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users.tom = {
      isNormalUser = true;
      initialPassword = "";
      extraGroups = [ "wheel" "networkmanager" ];
      useDefaultShell = true;
    };
  };

  networking = {
    hostName = "redfox";
    networkmanager.enable = true;
  };

  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
