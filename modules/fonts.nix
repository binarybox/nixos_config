{ config, pkgs, lib, ... }:
{
  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "Hack" ]; })
  ];
}