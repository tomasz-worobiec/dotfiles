{
  pkgs,
  pkgs-unstable,
  colorScheme,
  hostname,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../system/sddm.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  hardware.bluetooth = {
    enable = true;
    # On 25.05 package there is a bug which causes:
    # * bt devices to not connect automatically after reboot and
    # * keyboard input lag when mouse and keyboard are connected at the same time.
    # Temporary switch to unstable bluez. Restore after new release.
    package = pkgs-unstable.bluez;
  };
  services.pipewire.pulse.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    lshw
  ];

  programs = {
    dconf.enable = true;
    zsh.enable = true;
  };

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

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
  ];

  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;

    # useNetworkd = true;

    nat = {
      enable = true;
      externalInterface = "wlan0";
      internalInterfaces = [ "enp0s31f6" ];
    };

    firewall = {
      enable = true;
      allowedUDPPorts = [ 67 ];
    };
  };

  systemd.network.networks."10-eth0" = {
    matchConfig.Name = "enp0s31f6";
    networkConfig = {
      Address = "192.168.50.1/24";
      DHCPServer = true;
    };
    dhcpServerConfig = {
      PoolOffset = 10;
      PoolSize = 50;
      EmitDNS = true;
      DNS = [ "1.1.1.1" "8.8.8.8" ];
    };
  };

  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${colorScheme}";
    polarity = "dark";

    targets = {
      chromium.enable = true;
    };
  };

  time.timeZone = "Europe/Warsaw";

  system.stateVersion = "25.05";
}
