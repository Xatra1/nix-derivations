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
  version = "0.8.2";

  src = fetchFromGitHub {
    owner = "andrei-drexler";
    repo = "ironwail";
    tag = "v${finalAttrs.version}";
    hash = "sha256-h/3jZ97tzCsy2E5/GCrxMWfVG/LeteEYhN2b7Q8V1/Y=";
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

  meta = {
    description = "High-performance fork of the QuakeSpasm engine for id software's Quake";
    homepage = "https://github.com/andrei-drexler/ironwail";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ Xatra1 ];
  };
})
