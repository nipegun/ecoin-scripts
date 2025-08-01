#!/usr/bin/env python3

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

from itertools import permutations
from mnemonic import Mnemonic

def fGenerarYGuardarPermutacionesValidas(aPalabras, cLongitud, vArchivoSalida):
  vValidador = Mnemonic("english")
  vTotal = 0
  vValidas = 0

  with open(vArchivoSalida, "w") as vOut:
    for aPermutacion in permutations(aPalabras, cLongitud):
      vFrase = " ".join(aPermutacion)
      vTotal += 1
      if vValidador.check(vFrase):
        vValidas += 1
        vOut.write(vFrase + "\n")

  print(f"[✓] Validación terminada. De {vTotal} permutaciones, {vValidas} son válidas.")
  print(f"[→] Frases válidas guardadas en {vArchivoSalida}")

if __name__ == "__main__":

  # Lista de 12 palabras (puedes reemplazarla por lectura de archivo si querés)
  aPalabras = ["abandon", "baby", "cabbage", "dad", "eager", "fabric", "gadget", "habit", "ice", "jacket", "kangaroo", "lab"]

  cLongitudPermutacion = 12
  vArchivoDeValidas = "permutaciones_validas.txt"

  print("[*] Generando permutaciones y validando en tiempo real...")
  fGenerarYGuardarPermutacionesValidas(aPalabras, cLongitudPermutacion, vArchivoDeValidas)
