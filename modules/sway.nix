{config, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    swaylock-effects
    grim
    slurp
    mako
    upower
    wayland-utils
    wl-clipboard
  ];
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
