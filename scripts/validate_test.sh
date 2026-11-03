#!/usr/bin/env bash
# Runs validate.sh against small fixture repos. Each case commits a base set of
# themes as origin/main, then changes the working tree like a pull request.
set -u

validate=$(cd "$(dirname "$0")" && pwd)/validate.sh
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
fails=0

new_repo() {
  cd "$(mktemp -d -p "$tmp")" || exit 1
  git init -q
  mkdir themes screenshots
  : >README.md
}

# theme <file> <header line>...: a valid theme with screenshots and a gallery row
theme() {
  local f=$1
  shift
  {
    echo "/*"
    printf ' * %s\n' "$@"
    echo " */"
    echo ":root { --background: #fff; }"
    echo ".dark { --background: #000; }"
  } >"themes/$f.css"
  : >"screenshots/${f}_light.png"
  : >"screenshots/${f}_dark.png"
  echo "![](screenshots/${f}_light.png) ![](screenshots/${f}_dark.png)" >>README.md
}

as_main() {
  git add -A
  git -c user.name=test -c user.email=test@example.invalid commit -qm main
  git update-ref refs/remotes/origin/main HEAD
}

# expect <pass|fail> <case> [text the output must contain]
expect() {
  local out rc
  out=$("$validate" 2>&1)
  rc=$?
  if { [ "$1" = pass ] && [ "$rc" -ne 0 ]; } || { [ "$1" = fail ] && [ "$rc" -eq 0 ]; } ||
    [[ -n ${3-} && $out != *"$3"* ]]; then
    echo "FAIL $2: want $1${3:+ with \"$3\"}, got exit $rc"
    sed 's/^/    /' <<<"$out"
    fails=1
  else
    echo "ok   $2"
  fi
}

new_repo
theme base "@name: Base"
as_main
theme variations "@name: Variations" "@variations: mauve, peach"
expect pass "a theme with @variations"

new_repo
theme base "@name: Base"
as_main
theme shotless "@name: Shotless"
rm screenshots/shotless_dark.png
expect fail "a theme without a screenshot" "missing screenshots/shotless_dark.png"

new_repo
theme old "@name: Old Name"
as_main
theme old "@name: New Name"
expect fail "a changed @name with no @id" "old-name"

new_repo
theme old "@name: Old Name"
theme other "@name: Other"
as_main
rm themes/old.css
expect fail "a deleted theme" "old-name"

new_repo
theme old "@name: Old Name"
as_main
theme old "@name: New Name" "@id: old-name"
expect pass "a rename that keeps the id with @id"

new_repo
theme base "@name: Base"
as_main
theme rose_pine "@name: Rosé Pine"
expect fail "Rosé Pine with no @id" "@id"
theme rose_pine "@name: Rosé Pine" "@id: rose-pine"
expect pass "Rosé Pine with @id: rose-pine"

new_repo
theme rose_pine "@name: Rosé Pine"
as_main
theme rose_pine "@name: Rosé Pine" "@id: rose-pine"
expect pass "@id: rose-pine added to a Rosé Pine on main without @id"

exit "$fails"
