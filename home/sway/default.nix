{
  pkgs,
  config,
  ...
}: {
  home.file.".config/sway/wp.jpg".source = ../../wp.jpg;
  home.file.".config/sway/config".source = ./config;
  home.file.".config/sway/i3blocks.conf".source = ./i3blocks.conf;
  home.file.".config/sway/scripts" = {
    source = ./scripts;
    # copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };
}
