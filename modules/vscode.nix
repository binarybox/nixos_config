{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vscode
    direnv
    nixpkgs-fmt
    # (vscode-with-extensions.override {
    #   vscodeExtensions = with vscode-extensions; [
    #     bbenoist.nix
    #     ms-vscode-remote.remote-ssh
    #     jnoortheen.nix-ide
    #   ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    #     {
    #       name = "remote-ssh-edit";
    #       publisher = "ms-vscode-remote";
    #       version = "0.47.2";
    #       sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    #     }
    #     {
    #       name = "remote-containers";
    #       publisher = "ms-vscode-remote";
    #       version = "0.354.0";
    #       sha256 = "444f146f6b28ad196fe58b86af0c4b0c37151a228686d852ce51fafc24ea18a3";
    #     }
    #   ];
    # })
  ];
}
