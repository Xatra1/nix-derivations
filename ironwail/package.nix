{
  lib,
  stdenv,
  fetchFromGitHub,
  makeDesktopItem,
  copyDesktopItems,
  pkg-config,
  vulkan-headers,
  gzip,
  libGL,
  libvorbis,
  libmad,
  flac,
  curl,
  libopus,
  opusfile,
  libogg,
  libxmp,
  mpg123,
  vulkan-loader,
  SDL2,
  unstableGitUpdater,
}:
stdenv.mkDerivation (finalAttrs: {
  __structuredAttrs = true;
  pname = "ironwail";
  version = "0.8.1-unstable-2026-08-09";

  src = fetchFromGitHub {
    owner = "andrei-drexler";
    repo = "ironwail";
    rev = "4483c59a5a0fc7a1f0749c01fc78d886eff6ea9e";
    hash = "sha256-S/gXw8ICIuZnDmw2nMGd/W7LbYpwf3F8Z7jQnuZz+CM=";
  };

  sourceRoot = "source/Quake";

  buildInputs = [
    vulkan-headers
    libGL
    libvorbis
    libmad
    flac
    curl
    libopus
    libogg
    libxmp
    mpg123
    vulkan-loader
    opusfile
  ];

  nativeBuildInputs = [
    copyDesktopItems
    pkg-config
    gzip
    SDL2
  ];

  strictDeps = true;
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

      categories = [
        "Game"
        "ActionGame"
      ];
    })
  ];

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "High-performance fork of the QuakeSpasm engine for id software's Quake";
    homepage = "https://github.com/andrei-drexler/ironwail";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ Xatra1 ];
  };
})
