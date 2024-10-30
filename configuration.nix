{
    config,
    lib,
    pkgs,
    pkgs-unstable,
    ...
}:
let
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-session = "${pkgs.hyprland}/share/wayland-session";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
in
{
    imports = [
        ./hardware-configuration.nix
        ./system/hardware/default.nix
        ./system/services/default-system.nix
    ];

    hardware.bluetooth.enable = true;
    hardware.bluetooth.enableAudio = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = false;

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Warsaw";

    environment.systemPackages = with pkgs; [
        neovim
        wget
        git
        networkmanager
        zip
        unzip
        base16-schemes
        greetd.greetd
        greetd.tuigreet
        libdbusmenu-gtk3
        gtk3
    ];


	stylix = {
		enable = true;
		autoEnable = false;
		polarity = "dark";
		base16Scheme =
            "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
        targets = {
            chromium.enable = true;
        };
	};



  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
#   console = {
#     font = "Lat2-Terminus16";
#     keyMap = "pl";
#     useXkbConfig = true; # use xkb.options in tty.
#   };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.tom = {
        isNormalUser = true;
        initialPassword = "pw123";
        extraGroups = [ "wheel" "networkmanager" ];
        useDefaultShell = true;
    };

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

  environment.sessionVariables = {
    # Force Electron to use Wayland
    NIXOS_OZONE_WL = "1";
  };

    programs.dconf.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
    services.upower.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?

 nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

