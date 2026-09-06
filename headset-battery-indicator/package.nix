{
  lib,
  python3Packages,
  headsetcontrol,
  fetchFromGitHub,
}:
python3Packages.buildPythonApplication (finalAttrs: {
  pname = "headset-battery-indicator";
  version = "2.3.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ruflas";
    repo = "headset-battery-indicator";
    tag = "v${finalAttrs.version}";
    hash = "sha256-v2KFK2qFEiCUgBHZe5HdyMqiptpoxnnZia9uRxq6cqs=";
  };

  dependencies = [
    headsetcontrol
    python3Packages.pyside6
  ];

  build-system = [
    python3Packages.setuptools
  ];

  meta = {
    description = "Shows your headset's battery level in the system tray using HeadsetControl and Qt/PySide6.";
    homepage = "https://github.com/ruflas/headset-battery-indicator";
    license = lib.licenses.gpl3;
    platform = lib.platforms.linux;
  };
})
