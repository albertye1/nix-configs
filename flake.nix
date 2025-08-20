{
  description = "aly nixos flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # follows is used for inheritance.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    firefox-addons =
    {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    catppuccin,
    home-manager,
    plasma-manager,
    firefox-addons,
    ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations = {
      decibel = let
        username = "aly";
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };
       	specialArgs = {
          inherit inputs username;
          firefox-addons-nonfree = pkgs.callPackage firefox-addons { };
        };
      in
        nixpkgs.lib.nixosSystem {
       	  inherit specialArgs;
          system = "x86_64-linux";
          # set all inputs parameters as special arguments
          modules = [
       	    ./hosts/decibel
       	    ./users/${username}/nixos.nix
            catppuccin.nixosModules.catppuccin

       	    home-manager.nixosModules.home-manager
       	    {
       	      home-manager.useGlobalPkgs = true;
       	      home-manager.useUserPackages = true;
       	      home-manager.backupFileExtension = "backup";

       	      home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
       	      home-manager.users.${username} = {
                imports = [
                  ./users/${username}/home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
       	    }
          ];
        };
      saphira = let
        username = "aly";
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };
       	specialArgs = {
          inherit inputs username;
          firefox-addons-nonfree = pkgs.callPackage firefox-addons { };
        };
      in
        nixpkgs.lib.nixosSystem {
       	  inherit specialArgs;
          system = "x86_64-linux";
          # set all inputs parameters as special arguments
          modules = [
       	    ./hosts/saphira
       	    ./users/${username}/nixos.nix
            catppuccin.nixosModules.catppuccin

       	    home-manager.nixosModules.home-manager
       	    {
       	      home-manager.useGlobalPkgs = true;
       	      home-manager.useUserPackages = true;
       	      home-manager.backupFileExtension = "backup";

       	      home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
       	      home-manager.users.${username} = {
                imports = [
                  ./users/${username}/home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
       	    }
          ];
        };
      florinia = let
        username = "aly";
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
       	specialArgs = {
          inherit inputs username;
        };
      in
        nixpkgs.lib.nixosSystem {
       	  inherit specialArgs;
          system = "x86_64-linux";
          # set all inputs parameters as special arguments
          modules = [
       	    ./hosts/florinia
       	    ./users/${username}/nixos.nix
          ];
        };
    };
  };
}
