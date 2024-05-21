{ pkgs, ... }:

let
  helloWorld = pkgs.writeShellScriptBin "custom_waybar" ''
    exec waybar -c $HOME/.config/sway/waybar/config.json -s $HOME/.config/sway/waybar/style.css
  '';

in {
  environment.systemPackages = [ helloWorld ];
}