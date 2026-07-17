{
  pkgs ? import <nixpkgs> { },
}:

pkgs.lib.filesystem.packagesFromDirectoryRecursive {
  inherit (pkgs) callPackage;
  directory = ../nix-derivations;
}
