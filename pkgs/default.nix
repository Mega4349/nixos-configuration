{ pkgs ? import <nixpkgs> { } }: rec {

  bass = pkgs.callPackage ./bass { };
  danser = pkgs.callPackage ./danser { };
}
