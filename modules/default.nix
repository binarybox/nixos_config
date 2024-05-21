{
  imports =
    [
      # Include the results of the hardware scan.
      ./sway.nix
      ./vscode.nix
      ./zsh.nix
      ./tuigreet.nix
      ./alacritty.nix
      ./custom_waybar.nix
      # ./hello-world.nix
      # ./timer.nix
    ];
}
