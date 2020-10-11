{ lib, writeScript, exif, fish, inotify-tools }:

let
  unwords = lib.concatStringsSep " ";
  quoted = str: "'${str}'";
  getBin = input: lib.getBin input + "/bin";
  inputs = [ exif inotify-tools ];
  PATH = unwords (map (inp: quoted (getBin inp)) inputs);
in

writeScript "watcher" ''
    #!${lib.getBin fish}/bin/fish
    set -x PATH ${PATH} $PATH
    ${builtins.readFile ./watcher.sh}
''
