{ catppuccin, config, ... }: {
  imports = [
    ./browsers.nix
    ./common.nix
    ./game.nix
    ./media.nix
    ./xdg.nix
  ];
}
