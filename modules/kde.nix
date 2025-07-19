{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    sddm-astronaut
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [
      qtsvg
      qtmultimedia
      qtvirtualkeyboard
    ];
  };
  services.desktopManager.plasma6.enable = true;
}
