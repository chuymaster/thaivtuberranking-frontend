#!/bin/bash

set -euo pipefail

ENVIRONMENT="${1:-qa}"

# Install Dart and Flutter (custom)
if [ ! -d flutter ]; then
  git clone https://github.com/flutter/flutter.git -b stable
else
  cd flutter && git fetch --tags && git checkout stable && git pull && cd ..
fi
export PATH="$(pwd)/flutter/bin:$PATH"

# Optional: enable web support
flutter config --enable-web

# Optional: use FVM
flutter pub global activate fvm
export PATH="$HOME/.pub-cache/bin:$PATH"
fvm install
fvm flutter pub get

case "$ENVIRONMENT" in
  qa|QA)
    make build-qa
    ;;
  production|prod|release)
    make build-release
    ;;
  *)
    echo "Unknown environment: $ENVIRONMENT" >&2
    exit 1
    ;;
 esac
