{
  lib,
  stdenv,
  fetchurl,
  nerd-font-patcher,
}:
stdenv.mkDerivation (finalAttrs: {
  __structuredAttrs = true;
  pname = "miracode-nerdfont";
  version = "1.0";

  src = fetchurl {
    url = "https://github.com/IdreesInc/Miracode/releases/download/v${finalAttrs.version}/Miracode.ttf";
    hash = "sha256-Q+/D/TPlqOt779qYS/dF7ahEd3Mm4a4G+wdHB+Gutmo=";
  };

  nativeBuildInputs = [
    nerd-font-patcher
  ];

  strictDeps = true;
  dontUnpack = true;

  buildPhase = ''
    nerd-font-patcher --complete $src
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 $PWD/MiracodeNerdFont-Regular.ttf $out/share/fonts/truetype/MiracodeNerdFont-Regular.ttf
    runHook postInstall
  '';

  meta = {
    description = "The vectorized Minecraft-based font Miracode, patched with thousands of additional Nerd Font glyphs";
    homepage = "https://github.com/IdreesInc/Miracode";
    license = lib.licenses.ofl;
    platform = lib.platforms.linux;
    maintainers = with lib.maintainers; [ Xatra1 ];
  };
})
