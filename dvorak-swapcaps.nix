{ runCommand, kbd }:

runCommand "dvorak-swapcaps.map.gz" {} ''
  zcat "${kbd}/share/keymaps/i386/dvorak/dvorak.map.gz" \
      | sed -e 's/Caps_Lock/Control/g' \
      | gzip -c >$out
''
