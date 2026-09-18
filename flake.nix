{
  description = "LaTeX environment for the CV";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = [
              (pkgs.texliveSmall.withPackages (ps: with ps; [
                biblatex
                biblatex-ieee
                cabin
                cochineal
                comment
                babel-russian
                csquotes
                curve
                fontawesome5
                latexmk
                relsize
                silence
                xpatch
                xstring
                inconsolata
              ]))
              pkgs.biber
            ];

            shellHook = ''
              echo "LaTeX environment loaded"
              echo "Build with: latexmk -xelatex cv-llt.tex"
            '';
          };
        });
    };
}
