{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  hatch-fancy-pypi-readme,
  libgpiod,
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
  ];

  dependencies = [
    libgpiod
    hatch-fancy-pypi-readme
  ];

  pythonImportsCheck = [ "gpiodevice" ];

  postInstall = relocateDocs pname;

  meta = {
    description = "gpiodevice is a simple middleware library intended to make some user-facing aspects of interfacing with Linux's GPIO character device ABI (via gpiod) simpler and friendlier.";
    homepage = "https://github.com/pimoroni/gpiodevice-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ theconcierge ];
  };
}
