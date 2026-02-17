{ config, pkgs, catppuccin, inputs, ... }:

{
  imports = [
    ../../home/core.nix

    ../../home/shell
  ];

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "Albert Ye";
    userEmail = "me@albie.cat";
  };
}
