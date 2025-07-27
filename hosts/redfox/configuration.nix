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
    ../../system/greetd.nix
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

  system.stateVersion = "25.05";
}
