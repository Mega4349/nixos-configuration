{ buildGoModule, fetchFromGithub, lib, ... }:

buildGoModule  {
  pname = "danser";
  version = "0.9.1";

  src = fetchFromGithub {
    owner = "Wieku";
    repo = "danser-go";
    rev = "v0.9.1";
    hash = "";
  };

  vendorHash = lib.fakeSha256;
}
