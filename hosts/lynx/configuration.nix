{
  pkgs,
  hostname,
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
    lshw
  ];

  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.tom = {
      isNormalUser = true;
      initialPassword = "";
      extraGroups = [ "wheel" ];
      useDefaultShell = true;
    };
  };

  networking.hostName = "${hostname}";

  services.openssh.enable = true;

  time.timeZone = "Europe/Warsaw";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
