{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/system.nix
    ../../modules/ssh.nix
    ../../modules/git-deploy-watcher.nix
    ./hardware-configuration.nix
    ./firewall.nix
  ];

  virtualisation.docker.enable = true;

  services.gitDeployWatcher = {
    enable = true;
    user = "aly";
  };

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
