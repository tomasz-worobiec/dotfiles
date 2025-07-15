{
  pkgs,
  colorScheme,
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
    hostName = "redfox";
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
