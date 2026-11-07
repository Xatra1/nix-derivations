{
  lib,
  rustPlatform,
  fetchFromCodeberg,
  makeWrapper,
  pkg-config,
  mold,
  fontconfig,
  alsa-lib,
  libGL,
  libxkbcommon,
  wayland,
  makeDesktopItem,
  copyDesktopItems,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  __structuredAttrs = true;
  pname = "coin-clicker-reborn";
  version = "0.1.0";

  src = fetchFromCodeberg {
    owner = "solarfire";
    repo = "coin-clicker-reborn";
    rev = "288f4dfd0bf23a1f25dacac3e49e7bd9e480d9dc";
    hash = "sha256-CL60dIrhvS+jFJut0UxlDI8ld88/bvRp3efzWK6JK3I=";
  };
  cargoHash = "sha256-gaeZOEHv6J2TvL9YnrrumXu2YNXST6jIQe1MnuDsAF0=";

  strictDeps = true;
  nativeBuildInputs = [
    copyDesktopItems
    makeWrapper
    pkg-config
    mold
  ];

  buildInputs = [
    fontconfig # for yeslogic-fontconfig-sys
    alsa-lib.dev # for alsa-sys
  ];

  # Fix various issues with the resulting install:
  # - Copy sound files into the install directory and set AUDIO_FILES_PATH to
  # fix "no audio file" errors
  # - Rename the binary from coin_clicker_reborn to coin-clicker-reborn so
  # Nix can find and execute it when `nix run` is used.
  # - Fix Slint being unable to find libraries by making a wrapper with
  # LD_LIBRARY_PATH set
  postInstall = ''
    mkdir $out/assets
    cp -r $src/assets/snd $out/assets/

    mv $out/bin/coin_clicker_reborn $out/bin/coin-clicker-reborn

    wrapProgram $out/bin/coin-clicker-reborn \
        --prefix LD_LIBRARY_PATH : ${
          lib.makeLibraryPath [
            libGL
            libxkbcommon
            wayland
          ]
        } \
        --prefix AUDIO_FILES_PATH : $out/assets/snd

    for i in 16 24 32 48 64 72; do
      install -Dm644 $src/assets/img/coin.png $out/share/icons/hicolor/"$i"x"$i"/apps/coin-clicker-reborn.png
    done
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "coin-clicker-reborn";
      exec = "coin-clicker-reborn";
      icon = "coin-clicker-reborn";
      comment = "An idle clicker game where you aim to become the richest person alive";
      desktopName = "Coin Clicker Reborn";
      categories = [ "Game" ];
    })
  ];
})
