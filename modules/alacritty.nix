# ~/.config/nixpkgs/role/darwin-laptop/index.nix
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alacritty
  ];
}