{
  lib,
  python,
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
buildPythonPackage (finalAttrs: {
  pname = "inky";
  version = "2.3.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pimoroni";
    repo = "inky";
    tag = "v${finalAttrs.version}";
    hash = "sha256-1z2AZr6mlrl1O071iWS+tbWopUEUzLZe/QTmvl2atxQ=";
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

  postInstall = ''
    # the build explicitly copies over these docs files, which cause collisions with other pimoroni repos
    # preserve the files (especially license), but move elsewhere

    mkdir -p $out/share/doc/${finalAttrs.pname}
    mkdir -p $out/share/licenses/${finalAttrs.pname}

    mv "$out/${python.sitePackages}/LICENSE" $out/share/licenses/${finalAttrs.pname}/
    mv "$out/${python.sitePackages}/README.md" $out/share/doc/${finalAttrs.pname}/
    mv "$out/${python.sitePackages}/CHANGELOG.md" $out/share/doc/${finalAttrs.pname}/
  '';

  meta = {
    description = "Python library for Inky pHAT, Inky wHAT and Inky Impression e-paper displays for Raspberry Pi.";
    homepage = "https://github.com/pimoroni/inky";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ theconcierge ];
  };
})
