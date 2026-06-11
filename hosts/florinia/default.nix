{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/system.nix
    ../../modules/ssh.nix
    ./hardware-configuration.nix
    ./firewall.nix
  ];

  # use systemd-boot
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot.enable = true;
  };

  networking.hostName = "florinia";

  # enable networking
  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";
}
