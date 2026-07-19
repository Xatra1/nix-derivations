{
  pkgs ? <nixpkgs> { },
  fetchFromGitHub,
  makeDesktopItem,
}:
pkgs.stdenv.mkDerivation {
  name = "ironwail";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "andrei-drexler";
    repo = "ironwail";
    tag = "v0.8.1";
    hash = "sha256-h9P1nmdt6aGwqkb9X14syjWiJLXaIYyqffgpfY+/8e0=";
  };

  sourceRoot = "source/Quake";

  nativeBuildInputs = with pkgs; [
    copyDesktopItems
    pkg-config
    vulkan-headers
    gzip
    libGL
    libvorbis
    libmad
    flac
    curl
    libopus
    opusfile
    libogg
    libxmp
    mpg123
    vulkan-loader
    SDL2
  ];

  buildFlags = [ "DO_USERDIRS=1" ];

  enableParallelBuilding = true;

  preInstall = ''
    mkdir -p "$out/bin"
    mkdir -p "$out/share/quake"
    substituteInPlace Makefile --replace-fail "cp ironwail.pak /usr/local/games/quake" "cp ironwail.pak $out/share/quake/ironwail.pak"
    substituteInPlace Makefile --replace-fail "/usr/local/games/quake" "$out/bin/ironwail"
  '';

  postInstall = ''
    for i in 16 24 32 48 64 72; do
      install -Dm644 $src/Misc/QuakeSpasm_512.png $out/share/icons/hicolor/"$i"x"$i"/apps/ironwail.png
    done
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "ironwail";
      exec = "ironwail -basedir /home/solarfire/.local/share/ironwail";
      icon = "ironwail";
      comment = "Fork of the QuakeSpasm engine for id software's Quake";
      desktopName = "Ironwail";
      categories = [ "Game" ];
    })
  ];
}
