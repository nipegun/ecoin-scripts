#!/bin/bash

Usuario=pooladmin
Salto=%0A

## Ver si la variable de entorno HOME termina con una /
   CarpetaHome="$HOME"
   if [[ "$CarpetaHome" == */ ]]; then
     # Quitarle la /
     CarpetaHome=${CarpetaHome%?}
   fi

ltcHeaders=$($CarpetaHome/Cryptos/LTC/bin/litecoin-cli getblockchaininfo | jq .headers)
 ltcBlocks=$($CarpetaHome/Cryptos/LTC/bin/litecoin-cli getblockchaininfo | jq .blocks)
rvnHeaders=$($CarpetaHome/Cryptos/RVN/bin/raven-cli getblockchaininfo | jq .headers)
 rvnBlocks=$($CarpetaHome/Cryptos/RVN/bin/raven-cli getblockchaininfo | jq .blocks)
argHeaders=$($CarpetaHome/Cryptos/ARG/bin/argentum-cli getblockchaininfo | jq .headers)
 argBlocks=$($CarpetaHome/Cryptos/ARG/bin/argentum-cli getblockchaininfo | jq .blocks)

#ltcHeaders=$(/home/pooladmin/Cryptos/LTC/bin/litecoin-cli getblockchaininfo | jq .headers)
# ltcBlocks=$(/home/pooladmin/Cryptos/LTC/bin/litecoin-cli getblockchaininfo | jq .blocks)
#rvnHeaders=$(/home/pooladmin/Cryptos/RVN/bin/raven-cli getblockchaininfo | jq .headers)
# rvnBlocks=$(/home/pooladmin/Cryptos/RVN/bin/raven-cli getblockchaininfo | jq .blocks)
#argHeaders=$(/home/pooladmin/Cryptos/ARG/bin/argentum-cli getblockchaininfo | jq .headers)
# argBlocks=$(/home/pooladmin/Cryptos/ARG/bin/argentum-cli getblockchaininfo | jq .blocks)

$CarpetaHome/scripts/TelegramearHTML.sh "\
<b>Estado de los nodos cripto:</b>$Salto $Salto\
<i>Nodo Litecoin:</i>$Salto $Salto\
 Bloques totales: $ltcHeaders $Salto\
 Descargados: $ltcBlocks $Salto $Salto\
<i>Nodo Raven:</i>$Salto $Salto\
 Bloques totales: $rvnHeaders $Salto\
 Descargados: $rvnBlocks $Salto $Salto\
<i>Nodo Argentum:</i>$Salto $Salto\
 Bloques totales: $argHeaders $Salto\
 Descargados: $argBlocks $Salto $Salto\
<i>Nodo Monero:</i>$Salto $Salto\
 Bloques totales: $argHeaders $Salto\
 Descargados: $argBlocks $Salto $Salto\
<i>Nodo Chia:</i>$Salto $Salto\
 Bloques totales: $argHeaders $Salto\
 Descargados: $argBlocks $Salto $Salto\

