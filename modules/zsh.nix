{ config, pkgs, libs, ... }:
{
  programs = {
    zsh = {
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[─>](bold green)";
          error_symbol = "[─>](bold red)";
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    neofetch
  ];
  users.defaultUserShell = pkgs.zsh;
}
