{
config,
pkgs,
...
}: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        accent-color = "pink";
      };
      "org/gnome/desktop/input-sources" = {
        xkb-options = [ "ctrl:nocaps" ];
      };
      "org/gnome/desktop/background" = {
        picture-uri = "file://${../../wp.jpg}";
        picture-uri-dark = "file://${../../wp.jpg}";
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
        command = "ghostty";
        name = "Ghostty";
      };
    };
  };
}
