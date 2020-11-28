#!/bin/bash

# Napisz skrypt wyświetlający w kolejnych liniach argumenty przekazane
# do skryptu. Skrypt napisać w trzech wariantach: pierwszy z
# wykorzystaniem pętli for, drugi – pętli while i trzeci – petli
# until.
#
# Wariant `while`.

# While loop as long as there are arguments left.
while [[ $# -gt 0 ]]; do
  echo "$1"
  shift
done
