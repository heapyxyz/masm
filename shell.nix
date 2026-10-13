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
    unset TEMP TMP TEMPDIR TMPDIR
  '';
}
