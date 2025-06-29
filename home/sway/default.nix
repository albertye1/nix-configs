{
  pkgs,
  config,
  ...
}: {
  home.file.".config/sway/wp.jpg".source = ../../wp.jpg;
  home.file.".config/sway/config".source = ./config;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };
}
