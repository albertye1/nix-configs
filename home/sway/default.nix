{
  lib,
  pkgs,
  config,
  username,
  ...
}: {
  home.file.".config/sway/wp.jpg".source = ../../wp.jpg;
  home.file.".config/sway/i3blocks.conf".source = ./i3blocks.conf;
  home.file.".config/sway/scripts" = {
    source = ./scripts;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Shift+s" = "exec slurp | grim -g - - | wl-copy";
        "${modifier}+Ctrl+l" = "exec swaylock";
      };

      colors = {
        focused = {
          background = "$surface0";
          border = "$mauve";
          childBorder = "$mauve";
          indicator = "$mauve";
          text = "$mauve";
        };
        focusedInactive = {
          background = "$surface0";
          border = "$surface0";
          childBorder = "$surface0";
          indicator = "$surface0";
          text = "$overlay2";
        };
        unfocused = {
          background = "$base";
          border = "$surface0";
          childBorder = "$surface0";
          indicator = "$surface0";
          text = "$overlay2";
        };
        urgent = {
          background = "$surface0";
          border = "$red";
          childBorder = "$red";
          indicator = "$surface0";
          text = "$red";
        };
      };

      bars = [
        {
          fonts.size = 11.0;
          position = "top";
          colors = {
            background = "$base";
            statusline = "$text";
            separator = "$overlay0";
            activeWorkspace = {
              background = "$mauve";
              border = "$base";
              text = "$base";
            };
            focusedWorkspace = {
              background = "$mauve";
              border = "$base";
              text = "$base";
            };
            inactiveWorkspace = {
              background = "$base";
              border = "$base";
              text = "$overlay2";
            };
            urgentWorkspace = {
              background = "$red";
              border = "$base";
              text = "$base";
            };
          };
          statusCommand = "i3blocks -c ~/.config/sway/i3blocks.conf";
        }
      ];

      gaps = {
        inner = 10;
        outer = 10;
      };

      output = {
        "*" = {
          bg = "~/.config/sway/wp.jpg fill";
        };
      };

      startup = [
        { command = "zen"; }
      ];
    };
    wrapperFeatures = {
      gtk = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };
}
