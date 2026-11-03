#!/usr/bin/env bash
# Validates theme files against what qui actually enforces:
# .css extension, <= 1 MiB, a :root block and a .dark block each with
# at least one --variable (mirrors web/src/utils/themeParser.ts in qui).
# Also requires screenshots/<theme>_light.png and _dark.png for every theme,
# and a README gallery row that references them.
# Guards theme ids: qui stores the id of the selected theme, so a pull request
# must keep every id that origin/main has.
set -u

max_size=1048576
fail=0

# ponytail: block regex is [^}]* like qui's parser — nested braces unsupported there too
check_block() { # file selector
  perl -0777 -ne "exit(m/\Q$2\E\s*\{[^}]*--[a-zA-Z0-9-]+\s*:[^;]+;/s ? 0 : 1)" "$1"
}

# theme_id <fallback> < css: prints the id that qui gives the theme: @id, else
# the slug of @name (GenerateID in qui's internal/themes), else the file name.
# Exits 2 when there is no @id and the slug drops a letter of @name, for
# example the é of Rosé.
theme_id() {
  FALLBACK=$1 perl -CSD -0777 -ne '
    if (/\@id:\s*(.+?)\s*(?:\n|\*)/) { print $1; exit 0 }
    my $name = /\@name:\s*(.+?)\s*(?:\n|\*)/ ? lc $1 : "";
    (my $slug = $name) =~ s/[^a-z0-9]+/-/g;
    $slug =~ s/^-+|-+$//g;
    print $slug eq "" ? $ENV{FALLBACK} : $slug;
    exit($name =~ /(?![a-z])\p{L}/ ? 2 : 0);
  '
}

declare -A ids # id -> file on this branch

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

  name=$(basename "$f" .css)
  ok=1
  if [[ $name != _* ]]; then
    if id=$(theme_id "$name" <"$f"); then
      ids[$id]=$f
    else
      echo "FAIL $f: the id \"$id\" drops a letter of @name, add an @id line with a-z, 0-9 and -"
      ok=0
    fi
  fi

  size=$(wc -c <"$f")
  if [ "$size" -gt "$max_size" ]; then
    echo "FAIL $f: ${size} bytes exceeds 1 MiB"
    fail=1
    continue
  fi

  check_block "$f" ":root" || { echo "FAIL $f: missing :root block with at least one --variable"; ok=0; }
  check_block "$f" ".dark" || { echo "FAIL $f: missing .dark block with at least one --variable"; ok=0; }
  if [ "$name" != "_template" ]; then
    for mode in light dark; do
      [ -f "screenshots/${name}_${mode}.png" ] || { echo "FAIL $f: missing screenshots/${name}_${mode}.png"; ok=0; }
      grep -q "screenshots/${name}_${mode}.png" README.md || { echo "FAIL $f: screenshots/${name}_${mode}.png not in the README gallery"; ok=0; }
    done
  fi
  [ "$ok" -eq 1 ] || { fail=1; continue; }

  grep -q "@name:" "$f" || echo "WARN $f: no @name header, qui will show it as \"Untitled Theme\""
  echo "OK   $f"
done

base=origin/main
if git rev-parse -q --verify "$base^{commit}" >/dev/null; then
  while read -r p; do
    case "$p" in themes/_*) continue ;; *.css) ;; *) continue ;; esac
    # A theme on main whose id drops a letter fails the rule above. It must get
    # an @id on this branch, so its old id is not kept.
    old=$(git show "$base:$p" | theme_id "$(basename "$p" .css)") || continue
    [ -n "${ids[$old]+set}" ] && continue
    if [ -f "$p" ]; then
      echo "FAIL $p: changes the theme id \"$old\", keep it with an \"@id: $old\" line"
    else
      echo "FAIL $p: deletes the theme \"$old\""
    fi
    fail=1
  done < <(git ls-tree --name-only "$base" -- themes/)
else
  echo "WARN no $base, skipped the theme id check"
fi

exit "$fail"
