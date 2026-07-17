{
  pkgs ? <nixpkgs> { },
  fetchFromGitHub,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "kate-discord-rpc";

  src = fetchFromGitHub {
    owner = "leia-uwu";
    repo = "kate-discord-rpc";
    rev = "93a14a03887540f819b3b4885fd8c789aee05b19";
    hash = "sha256-TWMYy6oeFJZ1WTS9tNQLk9RcRBwkvVrZy9kVU2Kr90s=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = with pkgs; [
    cmake
    kdePackages.extra-cmake-modules
    kdePackages.kcoreaddons
    kdePackages.kconfig
    kdePackages.ktexteditor
    kdePackages.kwidgetsaddons
    kdePackages.qtbase
    kdePackages.wrapQtAppsHook
    rapidjson
  ];
}
