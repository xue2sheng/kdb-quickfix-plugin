# pwsh build.ps1

$env:RUSTFLAGS = "-L ..\\lib -l e -C target-feature=+crt-static" 
rustup default stable-gnu
cargo build --verbose --release --target x86_64-pc-windows-gnu

