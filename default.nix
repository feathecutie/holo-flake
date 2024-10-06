{
  rustPlatform,
  fetchFromGitHub,
  cmake,
  pcre2,
  protobuf,
  libyang,
  ...
}:

rustPlatform.buildRustPackage rec {
  pname = "holo";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "holo-routing";
    repo = "holo";
    rev = "v${version}";
    hash = "sha256-hC0OWqNk00Ss6iQU/7J79yUgYtZY7w9pfN6j1iSbWOU=";
  };

  cargoHash = "sha256-1PkpVdwp/DKLWwUxppv5r2fUWs929lj+GQG33jcgV08=";

  cargoPatches = [
    ./add-Cargo-lock.patch
    ./no-vendor-libyang.patch
  ];

  # cargoBuildFlags = "-p holo-northbound";

  buildAndTestSubdir = "holo-northbound";

  buildInputs = [
    pcre2
    libyang
  ];

  nativeBuildInputs = [
    cmake
    protobuf
  ];

  RUSTC_BOOTSTRAP = true;
  RUST_BACKTRACE = 1;
  CARGO_PROFILE_RELEASE_BUILD_OVERRIDE_DEBUG = true;

  outputHash = "";
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
}
