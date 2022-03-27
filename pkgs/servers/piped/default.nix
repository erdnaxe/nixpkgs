{ lib
, mkYarnPackage
, fetchFromGitHub
}:

mkYarnPackage {
  pname = "piped";
  version = "unstable-2022-03-24";

  src = fetchFromGitHub {
    owner = "TeamPiped";
    repo = "Piped";
    rev = "78e4e9a0a815752e845899584a29a3f0623405ae";
    hash = "sha256-YU2wvFrjqeJI+nvjK0Qmiw2tmFFEMIEj90OxYBP4Pj0=";
  };
  packageJSON = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;

  # We copy node_modules as vite plugins write to node_modules/.vite
  configurePhase = ''
    cp -r $node_modules node_modules
    chmod +w node_modules
  '';
  buildPhase = ''
    node ./node_modules/.bin/vite build --outDir $out
  '';
  installPhase = "true";
  distPhase = "true";

  meta = with lib; {
    description = "An alternative privacy-friendly YouTube frontend which is efficient by design";
    homepage = "https://github.com/TeamPiped/Piped";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ erdnaxe ];
  };
}
