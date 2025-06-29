{ config, pkgs, ... }:

{
  imports = [
    ../../home/core.nix

    ../../home/shell
    ../../home/sway
    ../../home/utils
  ];

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "Albert Ye";
    userEmail = "me@albie.cat";
  };
}
