{ pkgs, ... }:
{
    programs.neovim = {
        enable = true;

        # Add aliases
        vimAlias = true;
        viAlias = true;

        # Install dependencies
        extraPackages = with pkgs; [
            # LSP
            clang-tools
            lua-language-server
            nil
            omnisharp-roslyn
            rust-analyzer

            # Tools
            fd
            fzf
            gcc
            ripgrep
        ];
    };

    home.file."./.config/nvim" = {
        source = ./nvim;
        recursive = true;
    };
}
