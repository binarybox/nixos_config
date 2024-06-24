let
  pkgs = import <nixpkgs> { };
in
derivation {
  name = "hello";
  builder = "${pkgs.bash}/bin/bash";
  args = [ cargo install battop ];
  buildInputs = with pkgs; [
    cargo 
    rustup
  ];
  system = builtins.currentSystem;
}