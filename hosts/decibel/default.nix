{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/system.nix
    # pc also runs kde
    ../../modules/kde.nix
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

  networking.hostName = "decibel";

  # enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  system.stateVersion = "25.05";
}
