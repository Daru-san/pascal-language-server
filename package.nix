{
  xmake,
  stdenv,
  lazarus-paths,
  fpc,
  sqlite,
  lib,
}:
stdenv.mkDerivation {
  pname = "pasls";
  version = "26.01-dev";

  src = ./.;

  LAZARUS_PATHS = lazarus-paths;

  nativeBuildInputs = [
    xmake
    fpc
  ];

  buildInputs = [
    sqlite
  ];

  buildPhase = ''
    runHook preBuild

    export HOME=(mktemp -d)

    xmake build

    runHook postBuild
  '';

  installPhase = ''
    runHook preBuild

    mkdir -p $out/bin

    install -Dm775 build/linux/x86_64/release/pasls $out/bin/pasls

    runHook postBuild
  '';

  meta = {
    homepage = "https://github.com/genericptr/pascal-language-server";
    maintainers = [ lib.maintainers.daru-san ];
    license = lib.licenses.gpl3;
    mainProgram = "pasls";
  };
}
