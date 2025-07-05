{ config, pkgs, catppuccin, ... }:

{
  imports = [
    ../../home/core.nix

    ../../home/shell
    ../../home/kde
    ../../home/sway
    ../../home/utils
    ../../home/zed
  ];

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "Albert Ye";
    userEmail = "me@albie.cat";
  };
}
