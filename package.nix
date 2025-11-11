{
  xmake,
  stdenv,
  lazarus_paths,
  fpc,
  sqlite,
  lib,
}:
stdenv.mkDerivation {
  pname = "pasls";
  version = "26.01-dev";

  src = ./.;

  LAZARUS_PATHS = lazarus_paths;

  nativeBuildInputs = [
    xmake
    fpc
  ];

  buildInputs = [
    sqlite
  ];

  buildPhase = ''
    runHook preBuild

    xmake

    runHook postBuild
  '';

  meta = {
    homepage = "https://github.com/genericptr/pascal-language-server";
    maintainers = [ lib.maintainers.daru-san ];
    license = lib.licenses.gpl3;
    mainProgram = "pasls";
  };
}
