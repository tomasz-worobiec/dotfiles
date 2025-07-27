{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;

    extraPackages = with pkgs; [
      fd
      fzf
      gcc
      ripgrep
    ];
  };

  home.file.".config/nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "tomasz-worobiec";
      repo = "neovim-config";
      rev = "13312859680ada848a8b4e93e41cd4a0f465b248";
      sha256 = "sha256-PYGq6zyQuXHC7mqkdHRuBqTC0FpyiT4dS+jXBVxdtxw=";
    };
  };
}
