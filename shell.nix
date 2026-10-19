{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;

mkShell {
  buildInputs = [
    gnumake
    lld
    clang
    wineWow64Packages.stable
  ];

  shellHook = ''
    export LANG="pl_PL.UTF-8"
    export LC_ALL="pl_PL.UTF-8"
    unset TEMP TMP TEMPDIR TMPDIR
  '';
}
