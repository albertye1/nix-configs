{ inputs, options, config, lib, pkgs, username, firefox-addons-nonfree, ... }:
{
    programs.firefox = {
      enable = true;
      profiles = {
        aly = {
          id = 0;
          name = "${username}";
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "https://albie.cat";
            "browser.search.defaultenginename" = "DuckDuckGo";
            "browser.search.order.1" = "DuckDuckGo";
          };
          search = {
            force = true;
            default = "ddg";
            order = [ "ddg" "google" ];
            engines = {
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
              };
              # "Searx" = {
              #   urls = [{ template = "https://searx.aicampground.com/?q={searchTerms}"; }];
              #   iconUpdateURL = "https://nixos.wiki/favicon.png";
              #   updateInterval = 24 * 60 * 60 * 1000; # every day
              #   definedAliases = [ "@searx" ];
              # };
              "ddg".metaData.alias = "@d";
              "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
            };
          };
          extensions = with firefox-addons-nonfree; [
            ublock-origin
            onepassword-password-manager
            privacy-badger
          ];
        };
      };
    };
}

# TODO: Read this and do something with it
# https://github.com/NixOS/nixpkgs/issues/171978
# Firefox needs to be convinced to use p11-kit-proxy by running a command like this:
#
# modutil -add p11-kit-proxy -libfile ${p11-kit}/lib/p11-kit-proxy.so -dbdir ~/.mozilla/firefox/*.default
# I was also able to accomplish the same by making use of extraPolciies when overriding the firefox package:
#
#         extraPolicies = {
#           SecurityDevices.p11-kit-proxy = "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
#         };
