{ catppuccin, config, ... }: {
  imports = [
    ./browsers.nix
    ./common.nix
    ./firefox.nix
    ./game.nix
    ./media.nix
    ./xdg.nix
  ];
}
