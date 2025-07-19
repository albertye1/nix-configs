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
        # change these values for each laptop or find a better way to replicate this?
        vendorId = "0488";
        productId = "104b";
        name = "VEN_0488:00 0488:104B Touchpad";
      }
    ];

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Ctrl+Alt+T";
      command = "kitty";
    };
  };
}
