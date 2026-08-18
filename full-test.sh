#!/bin/bash
set -e

echo "=== Assignment 7 Test Start ==="

echo "[1] Building modules..."
make

echo "[2] Loading hello.ko..."
sudo insmod module/hello.ko || { echo "FAILED: hello.ko load"; exit 1; }

echo "[3] Checking dmesg for hello..."
dmesg | tail -n 20 | grep -i "hello" || { echo "FAILED: hello message"; exit 1; }

echo "[4] Unloading hello.ko..."
sudo rmmod hello || { echo "FAILED: hello.ko unload"; exit 1; }

echo "[5] Loading faulty.ko (expected crash)..."
sudo insmod module/faulty.ko || echo "[EXPECTED] faulty.ko intentionally fails"


echo "[6] Loading scull.ko..."
sudo insmod module/scull.ko || { echo "FAILED: scull.ko load"; exit 1; }

echo "[7] Creating scull device nodes..."
sudo mknod /dev/scull0 c 240 0 || true
sudo mknod /dev/scull1 c 240 1 || true

echo "[8] Testing scull read/write..."
echo "test" | sudo tee /dev/scull0 > /dev/null
sudo cat /dev/scull0 || { echo "FAILED: scull read"; exit 1; }

echo "[9] Unloading scull.ko..."
sudo rmmod scull || { echo "FAILED: scull.ko unload"; exit 1; }

echo "[10] Loading misc-modules.ko..."
sudo insmod module/misc-modules.ko || { echo "FAILED: misc-modules load"; exit 1; }

echo "[11] Unloading misc-modules.ko..."
sudo rmmod misc-modules || { echo "FAILED: misc-modules unload"; exit 1; }

echo "=== Assignment 7 Test Complete: SUCCESS ==="
exit 0
