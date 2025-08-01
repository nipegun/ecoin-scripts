#!/usr/bin/env python3

from mnemonic import Mnemonic

def mostrar_idiomas_disponibles():
  print("Idiomas disponibles en BIP39:")
  for i, lang in enumerate(Mnemonic.list_languages()):
    print(f" {i+1}. {lang}")
  print()

def pedir_idioma():
  mostrar_idiomas_disponibles()
  while True:
    idioma = input("Selecciona el idioma (por nombre, ej: english, spanish, etc): ").strip().lower()
    if idioma in Mnemonic.list_languages():
      return idioma
    else:
      print("Idioma no válido. Intenta de nuevo.\n")

def generar_mnemonico(idioma):
  mnemo = Mnemonic(language=idioma)
  entropy = mnemo.generate(strength=128)  # 128 bits = 12 palabras
  return entropy

def main():
  idioma = pedir_idioma()
  frase = generar_mnemonico(idioma)
  print("\nFrase mnemónica generada:")
  print(frase)

if __name__ == "__main__":
  main()
