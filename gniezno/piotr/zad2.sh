#!/bin/bash

# Napisz skrypt wyświetlający w kolejnych liniach argumenty przekazane
# do skryptu. Skrypt napisać w trzech wariantach: pierwszy z
# wykorzystaniem pętli for, drugi – pętli while i trzeci – petli
# until.


# Wariant `for`.

# Petla for wykonana na wszystkich argumentach skryptu.
for i in "$@" ; do
  # "$@" wypisuje wszystkie argumenty obok siebie w cudzyslowach.
  echo "$i"
done

# Petla while tak dlugo jak pozostaly jakies argumenty.
while [[ $# -gt 0 ]]; do
  echo "$1"
  shift
done

# Petla until dopoki liczba argumentow nie jest rowna 0.
# Blad, nie wykonuje sie, bo usunelismy juz parametry.
until [[ $# -eq 0 ]]; do
  echo "$1"
  shift
done
