{
  description = "A flake for my custom package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux"; # Change if needed
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system} = {
        fancy-cat = pkgs.callPackage ./default.nix {};
      };

      defaultPackage.${system} = self.packages.${system}.fancy-cat;
    };
}
