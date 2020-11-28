#!/bin/bash

# Napisz skrypt wyświetlający w kolejnych liniach argumenty przekazane
# do skryptu. Skrypt napisać w trzech wariantach: pierwszy z
# wykorzystaniem pętli for, drugi – pętli while i trzeci – petli
# until.
#
# Wariant `until`.

# Until loop until there are not arguments left.
until [[ $# -eq 0 ]]; do
  echo "$1"
  shift
done
