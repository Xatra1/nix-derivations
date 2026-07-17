{
  pkgs ? <nixpkgs> { },
  fetchurl,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "miracode-nerdfont";

  src = fetchurl {
    url = "https://github.com/IdreesInc/Miracode/releases/download/v1.0/Miracode.ttf";
    hash = "sha256-Q+/D/TPlqOt779qYS/dF7ahEd3Mm4a4G+wdHB+Gutmo=";
  };

  nativeBuildInputs = with pkgs; [
    nerd-font-patcher
  ];

  dontUnpack = true;

  buildPhase = ''
    nerd-font-patcher --complete $src
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 $PWD/MiracodeNerdFont-Regular.ttf $out/share/fonts/truetype/MiracodeNerdFont-Regular.ttf
    runHook postInstall
  '';
}
