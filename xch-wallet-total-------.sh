#!/bin/bash

VarChiaTotal=$(~/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia wallet show | grep pendable | cut -d':' -f2 | cut -d' ' -f2 | cut -d' ' -f1)
VarCarteraSincro=$(~/Cryptos/XCH/chia-blockchain/resources/app.asar.unpacked/daemon/chia wallet show | grep ync | cut -d':' -f2 | sed 's/ //')

if [[ $VarCarteraSincro == "Not synced" ]];
  then
    VarCarteraSincro="No"
  else
    VarCarteraSincro="Si"
fi

echo ""
echo "CARTERA"
echo "Sincronizada: $VarCarteraSincro"
echo "Total de XCH: $VarChiaTotal"
echo ""

