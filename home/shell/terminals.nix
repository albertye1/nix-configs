{ pkgs, ... }:

# terminals
let
  font = "JetBrainsMono Nerd Font";
in
{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 11;
      font_family = font;
      window_padding_width = 5;
    };
  };
}
