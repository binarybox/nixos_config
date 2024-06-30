{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lemurs
  ];

  services.displayManager = {
    enable = true;
    execCmd = "${pkgs.lemurs}/bin/lemurs";
  };
}
