{ lib, stdenvNoCC, fetchurl }:
stdenvNoCC.mkDerivation rec {
  pname = "material-bibata-cursors";
  version = "1.5.0";

  src = fetchurl {
    url = "https://github.com/SakibShahariar/material-bibata-cursor/releases/download/v${version}/bibata-material-dark-v${version}.tar.gz";
    hash = "sha256-igz93WB4fGWgeM5JS1cIwdaPPldhGP3gcBlJ7bQMugQ=";
  };
  sourceRoot = "bibata-material-dark-v${version}";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    cp -a Bibata-Material-* $out/share/icons/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Material Design 3 Bibata cursor themes (dark set)";
    homepage = "https://github.com/SakibShahariar/material-bibata-cursor";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
