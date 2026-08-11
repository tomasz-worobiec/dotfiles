{
  config,
  ...
}:
{
  flake.profiles.minimal.nixos =
    { pkgs, hostname, ... }:
    {
      imports = with config.flake; [
        nixosModules.nixpkgs
      ];

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

      nix.settings.trusted-users = [ "tom" ];

      services.openssh.enable = true;

      networking = {
        hostName = "${hostname}";
        networkmanager.enable = true;
      };

      time.timeZone = "Europe/Warsaw";
    };

  flake.profiles.minimal.home =
    { pkgs, username, ... }:
    {
      imports = with config.flake; [
        homeModules.nixpkgs
        homeModules.zsh
        homeModules.helix
        homeModules.zellij
      ];
      programs = {
        bat.enable = true;
        fzf.enable = true;
        git.enable = true;
        home-manager.enable = true;
        htop.enable = true;
        lazygit.enable = true;
        ranger.enable = true;
        ripgrep.enable = true;
        yazi.enable = true;
      };

      home.packages = with pkgs; [
        e2fsprogs
        zip
      ];

      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
      };
    };
}
