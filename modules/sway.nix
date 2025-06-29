{config, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    swaylock-effects
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
