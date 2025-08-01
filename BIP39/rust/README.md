# RustBIP39Validator

Calcula todas las permutaciones BIP39 válidas de 12 palabras dadas y las guarda en un archivo

## Instalación, compilación y ejecución

Instalar Rust, si no está instalado:

```
curl https://sh.rustup.rs -sSf | sh
```

Descargar los archivos:

```
cd /tmp
rm -rf /tmp/RustBIP39Validator/ 2> /dev/null
mkdir /tmp/RustBIP39Validator/
cd /tmp/RustBIP39Validator/
curl -sL https://raw.githubusercontent.com/nipegun/ecoin-scripts/refs/heads/main/BIP39/rust/Cargo.toml -O
mkdir src && cd src
curl -sL https://raw.githubusercontent.com/nipegun/ecoin-scripts/refs/heads/main/BIP39/rust/src/main.rs -O
cd /tmp/RustBIP39Validator/
```

Compilar:

```
cargo build --release
```

Ejecutar:

```
./target/release/validador_bip39
```

