#!/usr/bin/env bash
# Validates theme files against what qui actually enforces:
# .css extension, <= 1 MiB, a :root block and a .dark block each with
# at least one --variable (mirrors web/src/utils/themeParser.ts in qui).
set -u

max_size=1048576
fail=0

# ponytail: block regex is [^}]* like qui's parser — nested braces unsupported there too
check_block() { # file selector
  perl -0777 -ne "exit(m/\Q$2\E\s*\{[^}]*--[a-zA-Z0-9-]+\s*:[^;]+;/s ? 0 : 1)" "$1"
}

shopt -s nullglob
files=(themes/*)
if [ ${#files[@]} -eq 0 ]; then
  echo "no files in themes/"
  exit 1
fi

for f in "${files[@]}"; do
  [ -f "$f" ] || { echo "FAIL $f: not a regular file"; fail=1; continue; }

  case "$f" in
    *.css) ;;
    *) echo "FAIL $f: not a .css file"; fail=1; continue ;;
  esac

  size=$(wc -c <"$f")
  if [ "$size" -gt "$max_size" ]; then
    echo "FAIL $f: ${size} bytes exceeds 1 MiB"
    fail=1
    continue
  fi

  ok=1
  check_block "$f" ":root" || { echo "FAIL $f: missing :root block with at least one --variable"; ok=0; }
  check_block "$f" ".dark" || { echo "FAIL $f: missing .dark block with at least one --variable"; ok=0; }
  [ "$ok" -eq 1 ] || { fail=1; continue; }

  grep -q "@name:" "$f" || echo "WARN $f: no @name header, qui will show it as \"Untitled Theme\""
  echo "OK   $f"
done

exit "$fail"
