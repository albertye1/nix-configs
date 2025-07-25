{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/system.nix
    # pc runs sway
    ../../modules/sway.nix
    # pc contains nvidia gpu
    ../../modules/nvidia.nix
    # pc hardware settings
    ./hardware-configuration.nix
  ];

  # use systemd-boot
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot.enable = true;
  };

  # pc hostname is decibel aka the prettiest character in the pokemon fan game pokemon reborn
  networking.hostName = "decibel";

  # enable networking
  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";
}
