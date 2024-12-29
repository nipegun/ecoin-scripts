# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para calcular todas las combinaciones posibles de las palabras leidas en un archivo
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/crypto-scripts/main/BIP39-CalcularCombinacionesDe12.py | bash
# ----------

def fCombinarPalabras(words, group_size, combination=[], combinations=set()):
  if len(combination) == group_size:
    combinations.add(tuple(combination))
    return

  for word in words:
    if word not in combination:
      fCombinarPalabras(words, group_size, combination + [word], combinations)
  return combinations

def fLeerPalabrasDeArchivo(vArchivo):
  words = []
  with open(vArchivo, 'r') as file:
    for line in file:
      line = line.strip()
      line_words = line.split()
      words.extend(line_words)
  return words

vArchivo = '/root/BIP39-english-resumida2.txt'
words = fLeerPalabrasDeArchivo(vArchivo)

group_size = 12
all_combinations = fCombinarPalabras(words, group_size)

for combination in all_combinations:
  print(' '.join(combination))

  
