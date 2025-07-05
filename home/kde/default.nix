{
config,
pkgs,
username,
...
}: {
  home.file.".config/kdedefaults/wp.jpg".source = ../../wp.jpg;
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      wallpaper = "/home/${username}/.config/kdedefaults/wp.jpg";
    };

    input.touchpads = [
      {
        enable = true;
        disableWhileTyping = true;
        naturalScroll = true;
        middleButtonEmulation = true;
        vendorId = "093a";
        productId = "3012";
        name = "ASUP1207:00 093A:3012 Touchpad";
      }
    ];
  };
}
