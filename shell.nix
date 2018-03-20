{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, deepseq, mtl, plugin, random
      , stdenv
      }:
      mkDerivation {
        pname = "benchmarks";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          base deepseq mtl plugin random
        ];
        license = stdenv.lib.licenses.bsd3;
      };

  overlay = sup: super: {
              plugin = super.callCabal2nix "plugin" ./plugin {};
            };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages.extend(overlay)
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;


  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
