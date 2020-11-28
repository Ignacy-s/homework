#!/bin/bash

# Napisz skrypt wyświetlający w kolejnych liniach argumenty przekazane
# do skryptu. Skrypt napisać w trzech wariantach: pierwszy z
# wykorzystaniem pętli for, drugi – pętli while i trzeci – petli
# until.
#
# Wariant `for`.

# A for loop operating on all arguments expanded with $@.
for i in "$@"; do
  echo "$i"
done
