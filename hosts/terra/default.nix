{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/system.nix
  ];

  # terra because it's stuck in another computer ahahahahahahaah
  networking.hostName = "terra";

  # enable wsl
  wsl.enable = true;

  system.stateVersion = "25.05";
}
