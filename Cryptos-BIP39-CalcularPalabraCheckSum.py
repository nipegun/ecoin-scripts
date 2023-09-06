# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para calcular la palabra checksum de una lista de 11 o 23 palabras BIP39
#
# El script original es este: https://github.com/91DarioDev/bip39-checksum-words-finder/blob/main/main.py
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/c-scripts/main/Cryptos-BIP39-CalcularPalabraCheckSum.py | python3
# ----------

from hashlib import sha256
import binascii
import itertools


def get_bip39_words_list():
    lines = None
    with open('/tmp/BIP39english.txt') as file:
        lines = [line.rstrip() for line in file]
    assert(len(lines) == 2048)
    return lines


def main():
    bip39_words_list = get_bip39_words_list()

    while True:
        try:
            seed_string = input('Inserta las 11 o 23 palabras y presiona Enter:\n').lower()
        except KeyboardInterrupt:
            return

        # Convertir el string a lista
        seed_list = seed_string.split(' ')
        # Borrar los espacios en blanco de la lista
        seed_list = [word for word in seed_list if word]

        # Comprobar que todas las palabras estén en la lista BIP39
        all_words_in_bip39_list = True
        for word in seed_list:
            if word not in bip39_words_list:
                all_words_in_bip39_list = False
                print('\nERROR: La palabra {} no está en la lista BIP39\n'.format(word))

        # Evitar continuar si alguna de las palabras están en la lista BIP39
        if not all_words_in_bip39_list:
            continue

        # Comprobar si las palabras insertadas son 11 o 23
        if len(seed_list) != 11 and len(seed_list) != 23:
            print('\nERROR: {} words inserted\n'.format(len(seed_list)))
            continue

        break

    bits_string = ''
    for word in seed_list:
        decimal_index = bip39_words_list.index(word)
        binary_index = bin(decimal_index)[2:].zfill(11)
        bits_string += binary_index

    bits_to_add = None
    chars_for_checksum = None
    if len(seed_list) == 11:
        bits_to_add = 7
        chars_for_checksum = 1
    elif len(seed_list) == 23:
        bits_to_add = 3
        chars_for_checksum = 2

    combos = itertools.product(['0', '1'], repeat=bits_to_add)
    combos = [ ''.join(list(i)) for i in combos]
    combos = sorted(combos, key=lambda x: int(x, 2))

    candidates = '\n\nMISSING BITS - WORD:\n'
    for combo in combos:
        entropy = '{}{}'.format(bits_string, combo)
        hexstr = "{0:0>4X}".format(int(entropy,2)).zfill(int(len(entropy)/4))
        data = binascii.a2b_hex(hexstr)
        hs = sha256(data).hexdigest()
        last_bits = ''.join([ str(bin(int(hs[i], 16))[2:].zfill(4)) for i in range(0, chars_for_checksum) ])
        last_word_bin = '{}{}'.format(combo, last_bits)
        candidates += '{} - {}\n'.format(combo, bip39_words_list[int(last_word_bin, 2)])

    print(candidates)

if __name__ == "__main__":
    main()
