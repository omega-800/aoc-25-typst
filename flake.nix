{
  description = "AOC 2025";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = nixpkgs.lib.platforms.unix;
      eachSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              config = { };
              overlays = [ ];
            }
          )
        );
    in
    {
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            typst
          ];
        };
      });

      apps = eachSystem (pkgs: {
        default = {
          type = "app";
          program = "${pkgs.writeShellScript "typst-watch-open" ''
            ${pkgs.zathura}/bin/zathura "$PWD/main.pdf" &
            ${pkgs.typst}/bin/typst watch "$PWD/main.typ"
          ''}";
        };
      });

      results = nixpkgs.lib.mapAttrs (n: _: import ./src/${n}) (builtins.readDir ./src);
    };
}
