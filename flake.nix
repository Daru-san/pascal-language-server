{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = pkgs.lib;
        LAZARUS_PATHS =
          let
            mapper = paths: map (path: "${pkgs.lazarus-qt6}/share/lazarus/${path}") paths;
          in
          lib.makeSearchPath "x86_64-linux" (mapper [
            "components/lazutils/lib"
            "lcl/units"
            "components/codetools/units"
            "components/buildintf/units"
            "packager/units"
            "components/jcf2/lib"
          ]);
      in
      {
        packages = rec {
          pasls = pkgs.callPackage ./package.nix { lazarus-paths = LAZARUS_PATHS; };
          default = pasls;
        };
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            sqlite
            fpc
            xmake
          ];

          inherit LAZARUS_PATHS;

          LD_LIBRARY_PATH = lib.makeLibraryPath [
            pkgs.sqlite
          ];
        };
      }
    );
}
