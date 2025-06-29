{
  pkgs,
  inputs,
  config,
  username,
  ...
}: {
  programs = {
    firefox = {
      enable = true;
      profiles.${username} = {};
    };
  };
}
