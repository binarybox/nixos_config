{ pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./sway.nix
      ./vscode.nix
      ./zsh.nix
      # ./hello-world.nix
      # ./timer.nix
      ./fonts.nix
      ./waybar.nix
      ./wofi_calc.nix
      ./webapps.nix
      ./applications.nix
    ];
}
