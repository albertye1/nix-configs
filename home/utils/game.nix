{config, pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    gamemode
    vulkan-tools
  ];
}
