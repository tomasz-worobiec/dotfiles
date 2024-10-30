{
    config,
    pkgs,
    lib,
    ...
}:
{
    imports = [
        ./shell.nix
        ./lazygit.nix
        ./tmux.nix
    ];

    options = {
        cli.ripgrep.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to enable ripgrep.";
        };

        cli.fd.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to enable fd.";
        };

        cli.fzf.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to enable fzf.";
        };

        cli.bat.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to enable bat.";
        };
    };
    
    config = {
        home.packages = []
            ++ lib.optional (config.cli.ripgrep.enable) pkgs.ripgrep
            ++ lib.optional (config.cli.fd.enable) pkgs.fd
            ++ lib.optional (config.cli.fzf.enable) pkgs.fzf
            ++ lib.optional (config.cli.bat.enable) pkgs.bat;
    };
}

