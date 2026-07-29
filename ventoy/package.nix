{
  lib,
  stdenv,
  parted,
  fetchurl,
  makeWrapper,
  autoPatchelfHook,
}:
stdenv.mkDerivation (finalAttrs: {
  __structuredAttrs = true;
  pname = "ventoy";
  version = "1.1.17";

  src = fetchurl {
    url = "https://github.com/ventoy/Ventoy/releases/download/v${finalAttrs.version}/ventoy-${finalAttrs.version}-linux.tar.gz";
    hash = "sha256-f7TtCM72prTTndGSYNjIApGnjf35r31GFXHiPLvEOAU=";
  };

  patches = [
    ./000-nixos-sanitization.patch
  ];

  postPatch = ''
    find -type f -name \*.sh -exec chmod a+x {} \;
  '';

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  propagatedBuildInputs = [ parted ];

  dontBuild = true;

  configurePhase = ''
    (
      cd tool/x86_64
      rm ash* hexdump* mount.exfat-fuse* xzcat*
      for archive in *.xz; do
        xzcat "$archive" > "''${archive%.xz}"
        rm "$archive"
      done
      chmod a+x *
    )

    rm -r {tool/,VentoyGUI.}{i386,aarch64,mips64el} tool/x86_64/Ventoy2Disk.{gtk2,gtk3,qt5} plugin WebUI
    rm {CreatePersistentImg,ExtendPersistentImg,VentoyPlugson,VentoyVlnk,VentoyWeb}.sh VentoyGUI.x86_64 README

    mkdir -p $out/bin $out/share/ventoy
  '';

  installPhase = ''
    runHook preInstall

    cp -r . $out/share/ventoy
    makeWrapper $out/share/ventoy/Ventoy2Disk.sh $out/bin/ventoy --chdir $out/share/ventoy

    runHook postInstall
  '';

  meta = {
    description = "Tool to create a bootable drive for chainloading ISO files";
    homepage = "https://www.ventoy.net/en/index.html";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ Xatra1 ];
  };
})
