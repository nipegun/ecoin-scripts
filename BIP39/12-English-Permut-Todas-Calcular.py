#!/usr/bin/env python3

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

from itertools import permutations
from mnemonic import Mnemonic

def fGuardarPermutaciones(aPalabras, cLongitudPermutacion, vArchivoSalida):
  with open(vArchivoSalida, "w") as vArchivo:
    for aPermutacion in permutations(aPalabras, cLongitudPermutacion):
      vLinea = " ".join(aPermutacion)
      vArchivo.write(vLinea + "\n")

def fValidarPermutaciones(vArchivoEntrada, vArchivoSalida):
  vValidador = Mnemonic("english")
  with open(vArchivoEntrada, "r") as vIn, open(vArchivoSalida, "w") as vOut:
    vTotal = 0
    vValidas = 0
    for vLinea in vIn:
      vTotal += 1
      vFrase = vLinea.strip()
      if vValidador.check(vFrase):
        vValidas += 1
        vOut.write(vFrase + "\n")
    print(f"[✓] Validación terminada. De {vTotal} frases, {vValidas} son válidas.")
    print(f"[→] Frases válidas guardadas en {vArchivoSalida}")

if __name__ == "__main__":

  # Lista base (puedes reemplazar esto por lectura de archivo si lo deseas)
  aPalabras = ["abandon", "baby", "cabbage", "dad", "eager", "fabric", "gadget", "habit", "ice", "jacket", "kangaroo", "lab"]

  cLongitudPermutacion = 12
  vArchivoDePermutaciones = "todas_las_permutaciones.txt"
  vArchivoDeValidas = "permutaciones_validas.txt"

  print("[*] Generando permutaciones...")
  fGuardarPermutaciones(aPalabras, cLongitudPermutacion, vArchivoDePermutaciones)

  print("[*] Validando frases BIP39...")
  fValidarPermutaciones(vArchivoDePermutaciones, vArchivoDeValidas)
