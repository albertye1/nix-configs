{config, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    swaylock
    grim
    slurp
    mako
    upower
    wayland-utils
    wl-clipboard
    i3blocks
  ];
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
