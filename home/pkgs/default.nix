{ lib, ... }:

let
  pkgs = import <nixpkgs> { };
  callPackage = lib.callPackageWith (pkgs // packages);
  packages = {
    bass = callPackage ./bass { };
    danser = callPackage ./danser { };
  };
in
  packages

