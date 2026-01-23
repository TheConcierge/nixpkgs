{
  lib,
  python,
  buildPythonPackage,
  fetchFromGitHub,
  hatchling,
  hatch-fancy-pypi-readme,
  libgpiod,
}:
buildPythonPackage (finalAttrs: {
  pname = "gpiodevice";
  version = "0.0.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pimoroni";
    repo = "gpiodevice-python";
    tag = "v${finalAttrs.version}";
    hash = "sha256-1vZHRCHUmG+t0TYxYzc2qwElKrcLa0WmQ+FI5GTN1A8=";
  };

  build-system = [
    hatchling
    hatch-fancy-pypi-readme
  ];

  dependencies = [
    libgpiod
  ];

  pythonImportsCheck = [ "gpiodevice" ];

  postInstall = ''
    # the build explicitly copies over these docs files, which cause collisions with other pimoroni repos
    # preserve the files (especially license), but move elsewhere

    mkdir -p $out/share/doc/${finalAttrs.pname}
    mkdir -p $out/share/licenses/${finalAttrs.pname}

    mv "$out/${python.sitePackages}/LICENSE" $out/share/licenses/${finalAttrs.pname}
    mv "$out/${python.sitePackages}/README.md" $out/share/doc/${finalAttrs.pname}/
    mv "$out/${python.sitePackages}/CHANGELOG.md" $out/share/doc/${finalAttrs.pname}/
  '';

  meta = {
    description = "gpiodevice is a simple middleware library intended to make some user-facing aspects of interfacing with Linux's GPIO character device ABI (via gpiod) simpler and friendlier.";
    homepage = "https://github.com/pimoroni/gpiodevice-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ theconcierge ];
  };
})
