{
  pkgs,
  config,
  ...
}:
# media - control and enjoy audio/video
{
  # imports = [
  # ];

  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    # images
    imv
    gimp
    rapidraw
    # videos
    vlc
    # cad (i guess this counts here)
    freecad
    orca-slicer
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };

    obs-studio.enable = true;
  };

  services = {
    playerctld.enable = true;
  };
}
