{config, pkgs, ...}: {
  imports = [
    ./steam.nix
  ];

  programs.gamemode.enable = true;
}
