#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

check_prereqs() {
  echo "Checking prerequisites..."

  if ! node -v >/dev/null 2>&1; then
    echo "Node.js is required but not available in PATH."
    exit 1
  fi

  if ! java -version >/dev/null 2>&1; then
    echo "Java is required but not available in PATH."
    exit 1
  fi

  if ! adb version >/dev/null 2>&1; then
    echo "ADB is required but not available in PATH."
    exit 1
  fi

  if ! adb get-state >/dev/null 2>&1; then
    echo "No Android device is connected through ADB."
    exit 1
  fi
}

setup_dev_server() {
  echo "Configuring ADB reverse for localhost:5173..."
  adb reverse tcp:5173 tcp:5173
}

main() {
  check_prereqs
  setup_dev_server

  echo "Syncing Capacitor Android project..."
  npm run sync:dev

  if [[ "${1:-}" == "--android" ]]; then
    echo "Starting Android app with live reload..."
    npm run android
  else
    echo "Starting Vite dev server on port 5173..."
    npm run dev
  fi
}

main "$@"
