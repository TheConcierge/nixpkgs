{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  hatch-requirements-txt,
  hatch-fancy-pypi-readme,
  numpy,
  pillow,
  smbus2,
  spidev,
  gpiodevice,
}:

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
    hatch-requirements-txt
    hatch-fancy-pypi-readme
  ];

  dependencies = [
    numpy
    pillow
    smbus2
    spidev
    gpiodevice
  ];


  pythonImportsCheck = [ "inky" ];

  meta = {
    description = "Python library for Inky pHAT, Inky wHAT and Inky Impression e-paper displays for Raspberry Pi.";
    homepage = "https://github.com/pimoroni/inky";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ theconcierge ];
  };
}
