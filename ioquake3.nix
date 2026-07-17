{
  pkgs ? <nixpkgs> { },
  fetchFromGitHub,
  makeDesktopItem,
  #makeBinaryWrapper,
}:
pkgs.stdenv.mkDerivation {
  name = "ioquake3";

  src = fetchFromGitHub {
    owner = "ioquake";
    repo = "ioq3";
    rev = "67e4fa978530ae0a3f62fedb0a26ac4797443429";
    hash = "sha256-5YkZIBq53nzuvrCdA5sNZrqhNXBWN2j8R5VtlusLQtk=";
  };

  enableParallelBuilding = true;

  buildInputs = with pkgs; [ SDL2 ];

  nativeBuildInputs = with pkgs; [
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
}
