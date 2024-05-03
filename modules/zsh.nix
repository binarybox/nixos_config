{ config, pkgs, libs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "wedisagree";
        plugins = [
          "git"
          "npm"
          "history"
          "node"
          "rust"
        ];
      };
    };
  };
  users.defaultUserShell = pkgs.zsh;
}
