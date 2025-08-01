#!/usr/bin/env python3

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# Requisitos:
#   sudo apt -y update; sudo apt -y install python3-pip; sudo pip3 install mnemonic --break-system-packages

from itertools import permutations
from mnemonic import Mnemonic
from multiprocessing import Pool, cpu_count
from functools import partial

def fEsValida(vFrase):
  vValidador = Mnemonic("english")
  return vFrase if vValidador.check(vFrase) else None

def fGenerarYGuardarPermutacionesValidas(aPalabras, cLongitud, vArchivoSalida):
  print(f"[*] Usando {cpu_count()} núcleos para procesar permutaciones...")
  vTotal = 0
  vValidas = 0
  vPermutaciones = permutations(aPalabras, cLongitud)

  with Pool() as vPool, open(vArchivoSalida, "w") as vOut:
    for vResultado in vPool.imap_unordered(fEsValida, (" ".join(p) for p in vPermutaciones), chunksize=1000):
      vTotal += 1
      if vResultado:
        vValidas += 1
        print(f"[✔] Válida: {vResultado}")
        vOut.write(vResultado + "\n")

  print(f"[✓] Validación terminada. De {vTotal} permutaciones, {vValidas} son válidas.")
  print(f"[→] Frases válidas guardadas en {vArchivoSalida}")

if __name__ == "__main__":

  aPalabras = ["abandon", "baby", "cabbage", "dad", "eager", "fabric", "gadget", "habit", "ice", "jacket", "kangaroo", "lab"]

  cLongitudPermutacion = 12
  vArchivoDeValidas = "permutaciones_validas.txt"

  print("[*] Generando permutaciones y validando en paralelo...")
  fGenerarYGuardarPermutacionesValidas(aPalabras, cLongitudPermutacion, vArchivoDeValidas)

