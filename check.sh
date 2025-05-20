ENTRIES=$(awk '/```/{in_block = !in_block; next} in_block' README.md \
  | sed -e '/^[ 	]*$/d' -e '/^[ 	]*#/d')
[ ! -n "$ENTRIES" ] && echo "未在 README.md 中找到有效关键词" && exit 1

for i in $ENTRIES; do
    ARGS="$ARGS -e $i"
done

echo
echo "Matched Packages:"
echo

PACKAGE_LIST=`pm list packages | sed 's/^package://'`
for i in `printf '%s\n' "$PACKAGE_LIST" | grep -F $ARGS`; do
    echo "- $i"
done
echo
