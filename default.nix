{
  callPackage,
  lib,
  stdenv,
  pkgs,
  fetchFromGitHub,
  zig,
}:
stdenv.mkDerivation {
  pname = "fancy-cat";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "freref";
    repo = "fancy-cat";
    rev = "8b073a4dc20d75856f303592ca6ccd46648e2ae6";
    hash = "sha256-ziHtPfK9GOxKF800kk+kh12Fwh91xbjDYx9wv2pLZWI=";
  };

  patches = [ ./0001-changes.patch ];

  nativeBuildInputs = [
    zig.hook
  ];

  zigBuildFlags = [ "--release=fast" ];

  buildInputs = with pkgs; [
    mupdf
    harfbuzz
    freetype
    jbig2dec
    libjpeg
    openjpeg
    gumbo
    mujs
    libz
  ];

  postPatch = ''
    ln -s ${callPackage ./build.zig.zon.nix { }} $ZIG_GLOBAL_CACHE_DIR/p
  '';

  meta = with lib; {
    description = "PDF viewer for terminals using the Kitty image protocol";
    homepage = "https://github.com/freref/fancy-cat";
    license = licenses.mit;
    maintainers = with maintainers; [ ciflire ];
    mainProgram = "fancy-cat";
    inherit (zig.meta) platforms;
  };
}
