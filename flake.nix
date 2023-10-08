{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    esp-dev.url = "github:knarkzel/nixpkgs-esp-dev";
    flake-utils.url = "github:numtide/flake-utils";
    rust = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { nixpkgs, flake-utils, esp-dev, rust, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [
        esp-dev.overlays.default
        rust.overlays.default
      ];
      pkgs = import nixpkgs {inherit system overlays;};
    in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          esp-idf-esp32c3
          (rust-bin.nightly.latest.default.override {
            extensions = ["rust-src"];
          })
        ];
      };
    });
}
