{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;

mkShell {
  buildInputs = [
    gnumake
    lld
    wineWow64Packages.stable
  ];

  shellHook = ''
    unset TEMP TMP TEMPDIR TMPDIR
  '';
}
