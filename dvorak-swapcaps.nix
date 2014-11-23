{ runCommand }:

runCommand "dvorak-swapcaps.map.gz" {} ''
  gzip - <${./dvorak-swapcaps.map} >$out
''
