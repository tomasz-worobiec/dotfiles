{
  pkgs,
  lib,
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      editor = {
        line-number = "relative";
        mouse = true;
        cursorline = true;
        idle-timeout = 0;

        auto-save = {
          focus-lost = true;
          after-delay-enable = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
        };

        indent-guides = {
          render = true;
        };

        lsp = {
          display-messages = true;
        };
      };

      keys.normal = {
        "space" = {
          "h" = "jump_view_left";
          "j" = "jump_view_down";
          "k" = "jump_view_up";
          "l" = "jump_view_right";

          # Yazi integration
          "t" = [
            ":sh rm -f /tmp/unique-file"
            ":insert-output yazi \"%{buffer_name}\" --chooser-file=/tmp/unique-file"
            ":sh printf \"\\x1b[?1049h\\x1b[?2004h\" > /dev/tty"
            ":open %sh{cat /tmp/unique-file}"
            ":redraw"
          ];
        };
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        #        formatter.command = lib.getExe.pkgs.nixfmt-rfc-style;
      }
      {
        name = "rust";
        auto-format = true;
        #        formatter.command = lib.getExe.pkgs.nixfmt-rfc-style;
      }
      {
        name = "typst";
        auto-format = true;
      }
      {
        name = "cpp";
        auto-format = true;
        language-servers = [ "clangd" ];
      }
      {
        name = "c";
        auto-format = true;
        language-servers = [ "clangd" ];
      }
    ];

    extraPackages = with pkgs; [
      nil
      marksman
      nodePackages.bash-language-server
      yazi
    ];
  };
}
