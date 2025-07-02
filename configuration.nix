{
  pkgs,
    ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  users.users.tom = {
    isNormalUser = true;
    initialPassword = "";
    extraGroups = [ "wheel" ];
    useDefaultShell = true;
  };

  networking.hostName = "lynx";

  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
