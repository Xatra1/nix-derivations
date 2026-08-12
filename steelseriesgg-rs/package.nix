{
  lib,
  rustPlatform,
  fetchFromGitHub,
  mold,
  sccache,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  __structuredAttrs = true;
  pname = "steelseriesgg-rs";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "Ven0m0";
    repo = "steelseriesgg-rs";
    tag = "v${finalAttrs.version}";
    hash = "sha256-JyRQDHX92lvJH05Rf4kswvD/RtZzStbgJjL/MLDgrRo=";
  };
  cargoHash = "sha256-tKJ9eJ406hi1bditR1cxkBGs5DgIkrc8GxzxKtY7IMU=";

  enableParallelBuilding = true;
  strictDeps = true;

  nativeBuildInputs = [
    mold
    sccache
  ];

  env.RUSTFLAGS = "-Clink-arg=-fuse-ld=mold";
  checkFlags = [
    # Fails due to a "Permission denied" error when running in the Nix build sandbox.
    "--skip=test_diagnostic_log_permissions"
  ];

  configurePhase = ''
    sed -i '/rustc-wrapper = "sccache"/s/^#//' .cargo/config.toml
  '';

  meta = {
    description = "Open-source SteelSeries GG replacement for Linux";
    homepage = "https://github.com/Ven0m0/steelseriesgg-rs";
    license = lib.licenses.mit;
    mainProgram = "ssgg";
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ Xatra1 ];
  };
})
