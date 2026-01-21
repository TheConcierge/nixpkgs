{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  hatch-fancy-pypi-readme,
  hatch-requirements-txt,
  numpy,
  pillow,
  smbus2,
  spidev,
  gpiodevice,
}:
let
  # helper for relocating docs safely
  relocateDocs = pname: ''
    mkdir -p $out/share/doc/${pname}
    mkdir -p $out/share/licenses/${pname}
    for f in LICENSE* README* CHANGELOG*; do
      if [ -f "$f" ]; then
        cp "$f" $out/share/doc/${pname}/
      fi
    done
    # move license to share/licenses if present
    if [ -f "LICENSE" ]; then
      cp LICENSE $out/share/licenses/${pname}/
    fi
  '';
in
buildPythonPackage rec {
  pname = "inky";
  version = "2.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pimoroni";
    repo = "inky";
    tag = "v${version}";
    hash = "sha256-4bGX1NQ/y67Ctm9yWAlH+UZFYejdUJ1i/h8fEbQeZog=";
  };

  build-system = [
    hatchling
    hatch-fancy-pypi-readme
    hatch-requirements-txt
  ];

  dependencies = [
    numpy
    pillow
    smbus2
    spidev
    gpiodevice
  ];

  pythonImportsCheck = [ "inky" ];

  postInstall = relocateDocs pname;

  meta = {
    description = "Python library for Inky pHAT, Inky wHAT and Inky Impression e-paper displays for Raspberry Pi.";
    homepage = "https://github.com/pimoroni/inky";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ theconcierge ];
  };
}
