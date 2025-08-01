use bip39::{Language, Mnemonic};
use itertools::Itertools;
use rayon::prelude::*;
use std::fs::File;
use std::io::{self, BufWriter, Write};
use std::sync::{Arc, Mutex};

const LONGITUD: usize = 12;
const ARCHIVO_SALIDA: &str = "PermutacionesUsables.txt";

fn main() {
  println!("[*] Idioma: solo se soporta 'english' con esta versión de bip39.");

  println!("\n  Ingrese las 12 palabras separadas por espacio:");
  println!("  Ejemplo: abandon baby cabbage dad eager fabric gadget habit ice jacket kangaroo lab");

  let mut entrada = String::new();
  io::stdin()
    .read_line(&mut entrada)
    .expect("[✗] Error al leer la entrada.");

  let palabras: Vec<String> = entrada
    .trim()
    .split_whitespace()
    .map(|s| s.to_string())
    .collect();

  if palabras.len() != LONGITUD {
    eprintln!(
      "[✗] Error: Se esperaban 12 palabras, pero se recibieron {}.",
      palabras.len()
    );
    std::process::exit(1);
  }

  println!("[*] Generando permutaciones y validando en paralelo...");
  let total_permutaciones = factorial(LONGITUD);
  println!(
    "[*] Total de permutaciones posibles: {} (puede tardar mucho)",
    total_permutaciones
  );

  let archivo = File::create(ARCHIVO_SALIDA).expect("[✗] No se pudo crear el archivo de salida.");
  let writer = Arc::new(Mutex::new(BufWriter::new(archivo)));

  let validas = Arc::new(Mutex::new(0usize));
  let total = Arc::new(Mutex::new(0usize));

  palabras
    .iter()
    .permutations(LONGITUD)
    .par_bridge()
    .for_each(|p| {
      let frase = p.into_iter().join(" ");
      {
        let mut t = total.lock().unwrap();
        *t += 1;
      }
      if Mnemonic::parse_in_normalized(Language::English, &frase).is_ok() {
        // println!("[✔] Válida: {}", frase);
        let mut w = writer.lock().unwrap();
        writeln!(w, "{}", frase).unwrap();
        let mut v = validas.lock().unwrap();
        *v += 1;
      }
    });

  println!(
    "[✓] Validación completada. De {} permutaciones, {} fueron válidas.",
    *total.lock().unwrap(),
    *validas.lock().unwrap()
  );
  println!("[→] Guardadas en {}", ARCHIVO_SALIDA);
}

fn factorial(n: usize) -> usize {
  (1..=n).product()
}
