#!/usr/bin/env bash
set -euo pipefail

echo "==> 1. Flutter pub get"
flutter pub get

echo "==> 2. Code generation (Drift & Riverpod)"
dart run build_runner build

echo "==> 3. Static analysis"
flutter analyze

echo "==> 4. Unit & widget tests"
flutter test

echo "==> Semua verifikasi RumahKu lulus!"
