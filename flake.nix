{
  description = "template-rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ ];
        pkgs = (import nixpkgs) {
          inherit system overlays;
        };

        buildInputs = [ ];
        nativeBuildInputs = [ ];
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs =
            with pkgs;
            [
              git
              act
              just
              nixd
              nixfmt-rfc-style
            ]
            ++ buildInputs
            ++ nativeBuildInputs;
        };
      }
    );
}
