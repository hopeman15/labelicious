#!/usr/bin/env bash

set -o pipefail

mkdir -p coverage

echo "🏗️ Prepare kcov"
for script in ./src/*.sh; do
  kcov --include-path=src coverage "$script" &
done

wait

echo "🧪 Testing"
make test

report_path="$(realpath coverage/index.html)"

echo "🧪 Coverage report generated:"
echo "📂 file://$report_path"
