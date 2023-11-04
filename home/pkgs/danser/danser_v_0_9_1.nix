{ buildGo121Module
, fetchzip
, ffmpeg
, gcc
, go_1_21
, gsettings-desktop-schemas
, gtk3
, lib
, makeWrapper
, pkgs
, stdenv
, 
}:
let
  pname = "danser";
  version = "0.9.1";
  git_repo_owner = "Wieku";
  git_repo = "danser-go";

  bass = pkgs.callPackage ../bass { };

  src = fetchzip {
    name = "${pname}-${version}-source";
    url = "https://github.com/${git_repo_owner}/${git_repo}/archive/refs/tags/${version}.tar.gz";
    hash = "sha256-RhL3Dx/IgtntifvtY4nw8fvp5BjOI1JMzY+wqrkA3Lo=";
  };

  goModules = (buildGo121Module {
    inherit pname src vendorHash version;
  }).goModules;

  vendorHash = "sha256-0n7HT+B+xpjvLbJLSJJHv9TozT+Joen5gXbGCet5K7I=";

  libs = with pkgs; [
    alsa-lib
    bass.bass
    bass.bass_fx
    bass.bassmix
    ffmpeg
    gtk3
    libGL
    libyuv
    pkg-config
    xorg.libX11
    xorg.libXxf86vm
  ];
in
stdenv.mkDerivation {
  inherit pname version src;
  patches = [ ./patches/env-paths.patch ];

  Cgo_1_21_ENABLED = true;
  enableParallelBuilding = true;

  buildInputs = libs;
  nativeBuildInputs = libs ++ [ go_1_21 makeWrapper ];

  configurePhase = ''
    export GOCACHE=$TMPDIR/go-cache
    export GOPATH="$TMPDIR/go"
    export GOPROXY=off
    cp -r --reflink=auto ${goModules} vendor
  '';

  buildPhase = ''
    runHook preBuild

    mkdir -p $out

    ${go_1_21}/bin/go run tools/assets/assets.go ./ $out/
    ${go_1_21}/bin/go build -trimpath -ldflags "-s -w -X 'github.com/wieku/danser-go_1_21/build.VERSION=${version}' -X 'github.com/wieku/danser-go_1_21/build.Stream=Release'" -buildmode=c-shared -o $out/danser-core.so -v -x

    mv $out/danser-core.so $out/libdanser-core.so
    # cp {libbass.so,libbass_fx.so,libbassmix.so,libyuv.so} $out/

    ${gcc}/bin/gcc -no-pie --verbose -O3 -o $out/danser-cli -I. cmain/main_danser.c -I$out/ -Wl,-rpath,'$ORIGIN' -L$out/ -ldanser-core

    ${gcc}/bin/gcc -no-pie --verbose -O3 -D LAUNCHER -o $out/danser -I. cmain/main_danser.c -I$out/ -Wl,-rpath,'$ORIGIN' -L$out/ -ldanser-core

    rm $out/danser-core.h

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    mkdir $out/bin
    mkdir $out/lib

    mv $out/*.so $out/lib

    makeWrapper $out/danser $out/bin/danser \
      --prefix XDG_DATA_DIRS : ${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name} \
      --prefix PATH : ${ffmpeg}/bin \
      --suffix LD_LIBRARY_PATH : ${lib.strings.makeLibraryPath libs}:$out/lib

    makeWrapper $out/danser-cli $out/bin/danser-cli \
      --prefix XDG_DATA_DIRS : ${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS \
      --prefix PATH : ${ffmpeg}/bin \
      --suffix LD_LIBRARY_PATH : ${lib.strings.makeLibraryPath libs}:$out/lib

    runHook postInstall
  '';

  meta = with lib; {
    description = "Dancing visualizer of osu! standard maps and custom osu! client written in go_1_21. Also a generator for osu! videos.";
    homepage = "https://github.com/${git_repo_owner}/${git_repo}";
    license = licenses.gpl3;
    maintainers = with maintainers; [ Mega4349 ];
  };
}

