{
  lib,
  stdenv,
  fetchFromGitHub,
  makeDesktopItem,
  copyDesktopItems,
  unstableGitUpdater,
  makeBinaryWrapper,
  cmake,
  SDL2,
}:
stdenv.mkDerivation (finalAttrs: {
  __structuredAttrs = true;
  pname = "ioquake3";
  version = "0-unstable-2026-07-19";

  src = fetchFromGitHub {
    owner = "ioquake";
    repo = "ioq3";
    rev = "588393618dbc82e7207c21c6ddecca229944a03a";
    hash = "sha256-BiyBg+Jy8V2v119NqcX/YUwDb8zZdq7+FfjWNenaEA4=";
  };

  enableParallelBuilding = true;
  strictDeps = true;
  buildInputs = [ SDL2 ];

  nativeBuildInputs = [
    copyDesktopItems
    makeBinaryWrapper
    cmake
  ];

  postInstall = ''
    install -Dm644 $src/misc/quake3.svg $out/share/icons/hicolor/scalable/apps/ioquake3.svg

    makeWrapper $out/ioquake3 $out/bin/ioquake3
    makeWrapper $out/ioq3ded $out/bin/ioq3ded
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "ioquake3";
      exec = "ioquake3 +set fs_homepath /home/solarfire/.local/share/Quake3";
      icon = "ioquake3";
      comment = "Fast-paced 3D first-person shooter, a community effort to continue supporting/developing id's Quake III Arena";
      desktopName = "ioquake3";

      categories = [
        "Game"
        "ActionGame"
      ];
    })
  ];

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Fast-paced 3D first-person shooter, a community effort to continue supporting/developing id's Quake III Arena";
    homepage = "https://ioquake3.org/";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ Xatra1 ];
  };
})
