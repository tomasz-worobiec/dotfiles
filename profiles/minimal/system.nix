{
  pkgs,
  hostname,
  ...
}:
{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    lshw
    arp-scan
  ];

  programs = {
    dconf.enable = true;
    zsh.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users.tom = {
      isNormalUser = true;
      initialPassword = "";
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      useDefaultShell = true;
    };
  };

  services.openssh.enable = true;

  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";
}
