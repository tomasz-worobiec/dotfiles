{
    config,
    pkgs,
    pkgs-unstable,
    ...
}:
let
    username = "tom";
in
{
    home = {
        username = username;
        homeDirectory = "/home/${username}";
        sessionVariables = {
            EDITOR = "nvim";
        };
        stateVersion = "24.05";
    };

    imports = [
        ./modules/cli/default.nix
        ./modules/browser/default.nix
        ./modules/desktop-env/default.nix
        ./modules/editors/neovim/default.nix
    ];

    cli = {
        ripgrep.enable = true;
        fd.enable = true;
        fzf.enable = true;
        bat.enable = true;
    };

    programs = {
        home-manager.enable = true;
        alacritty.enable = true;
    };

    stylix = {
        enable = true;
        autoEnable = false;

        base16Scheme = 
            "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
        polarity = "dark";
        image = /home/${username}/wallpapers/1;
        
        # TODO: Fix
        fonts = {
            sansSerif = {
                name = "CommitMono Nerd Font Mono:style=Regular";
                package = pkgs.commit-mono;
            };
            monospace = {
                name = "CommitMono Nerd Font Mono";
                package = pkgs.commit-mono;
            };
        };

        cursor = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
            size = 12;
        };

        targets = {
            alacritty.enable = true;
            neovim.enable = true;
            tmux.enable = true;
            gnome.enable = true;
            gtk.enable = true;
            lazygit.enable = true;
            # hyprland.enable = true;
            fzf.enable = true;
        };
    };

    home.packages = with pkgs; [
        (pkgs.nerdfonts.override { fonts = [ "CommitMono" ]; })
        openshot-qt
        cargo
        rustc
        gcc
    ];
}
