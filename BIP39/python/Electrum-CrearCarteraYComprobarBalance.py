#!/usr/bin/env python3

import subprocess
import json
import time
import datetime
import os
import shutil
import sys

# Configuración
vRutaACarpetaDeCarteras = "/mnt/c/Carteras"  # sin '/' final
vSleepSeg = 0.1  # pausa entre iteraciones

def run(cmd):
  p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
  if p.returncode != 0:
    err = p.stderr.strip()
    raise RuntimeError(f"Error: {' '.join(cmd)}\n{err if err else '(stderr vacío)'}")
  return p.stdout.strip()

def electrum(*args):
  #return run(["electrum", "--testnet", *args])
  return run(["electrum", *args])

def now_tag():
  # Evitar ':' para NTFS: usar aYYYYmMMdDD@HH-MM-SS
  return datetime.datetime.now().strftime("a%Ym%md%d@%H-%M-%S")

def wallet_path(ts):
  return os.path.join(vRutaACarpetaDeCarteras, f"{ts}.wallet")

def ensure_dir(path):
  os.makedirs(path, exist_ok=True)

def read_wallet_seed(path):
  with open(path, "r", encoding="utf-8") as f:
    data = json.load(f)
  if "keystore" in data and isinstance(data["keystore"], dict):
    return data["keystore"].get("seed", "")
  if "keystores" in data and isinstance(data["keystores"], list) and data["keystores"]:
    return data["keystores"][0].get("seed", "")
  return ""

def get_balance(path):
  out = electrum("-w", path, "getbalance")
  try:
    j = json.loads(out)
  except json.JSONDecodeError:
    for line in out.splitlines():
      if "confirmed" in line:
        digits = ''.join(ch for ch in line if (ch.isdigit()))
        return int(digits) if digits else 0
    raise
  v = j.get("confirmed", 0)
  if isinstance(v, str):
    try:
      v = int(v)
    except ValueError:
      v = int(float(v))
  return v

def main():
  ensure_dir(vRutaACarpetaDeCarteras)

  # Asegurar testnet y daemon levantado (idempotente)
  try:
    run(["electrum", "setconfig", "testnet", "true"])
  except Exception:
    pass
  try:
    run(["electrum", "daemon", "start"])
  except Exception:
    pass

  while True:
    vFechaDeEjec = now_tag()
    vWalletPath = wallet_path(vFechaDeEjec)

    # Crear y cargar cartera (silencioso)
    electrum("-w", vWalletPath, "create")
    electrum("-w", vWalletPath, "load_wallet")

    # Consultar balance (testnet)
    try:
      vBalance = get_balance(vWalletPath)
    except Exception:
      time.sleep(vSleepSeg)
      electrum("-w", vWalletPath, "load_wallet")
      vBalance = get_balance(vWalletPath)

    # Leer seed del fichero
    vSeed = read_wallet_seed(vWalletPath)

    # Renombrar según balance
    if vBalance == 0:
      vDestino = os.path.join(vRutaACarpetaDeCarteras, f"0-{vSeed}.wallet")
      shutil.move(vWalletPath, vDestino)
      time.sleep(vSleepSeg)
      continue
    else:
      vDestino = os.path.join(vRutaACarpetaDeCarteras, f"{vBalance}-{vSeed}.wallet")
      shutil.move(vWalletPath, vDestino)
      print(f"Encontrada wallet con balance {vBalance} (testnet). Guardada como:\n{vDestino}")
      break

if __name__ == "__main__":
  try:
    main()
  except KeyboardInterrupt:
    sys.exit(130)

