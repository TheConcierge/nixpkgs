{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  hatch-requirements-txt,
  hatch-fancy-pypi-readme,
  libgpiod,
}:

buildPythonPackage rec {
  pname = "gpiodevice";
  version = "0.0.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pimoroni";
    repo = "gpiodevice";
    tag = "v${version}";
    hash = "sha256-1vZHRCHUmG+t0TYxYzc2qwElKrcLa0WmQ+FI5GTN1A8=";
  };

  build-system = [
    hatchling
    hatch-requirements-txt
    hatch-fancy-pypi-readme
  ];

  dependencies = [
    libgpiod
  ];


  pythonImportsCheck = [ "gpiodevice" ];

  meta = {
    description = "gpiodevice is a simple middleware library intended to make some user-facing aspects of interfacing with Linux's GPIO character device ABI (via gpiod) simpler and friendlier.";
    homepage = "https://github.com/pimoroni/gpiodevice-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ jamiemagee ];
  };
}
