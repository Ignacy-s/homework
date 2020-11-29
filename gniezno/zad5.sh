#!/bin/bash

# Sun 29 Nov 2020 06:30:34 PM CET

# Napisz skrypt kopiujący plik wskazany pierwszym argumentem wywołania
# do wszystkich katalogów wskazanych kolejnymi argumentami.

# Pelna liste testow do "[[" mozna znalezc tutaj: man bash >
# /conditional > nacisnac n kilka razy > przewinac w dol strzalkami.

# Sprawdzamy czy skrypt dostal zero argumentow.
if [[ $# -eq 0 ]]; then
  echo "Pusta lista argumentów."
  exit 1
fi

# Sprawdzamy czy istnieje plik z pierwszego parametru i czy mozna go
# odczytac.
if [[ ! -r "$1" ]]; then
  # Plik nie istnieje, albo nie mozna go odczytac. Zglaszamy blad.
  echo "Plik $1 nie istnieje lub nie mozna go odczytac."
  exit 1
fi

# Zapamietujemy adres pierwszego pliku.
plik_do_kopiowania="$1"

# Przesuwamy parametry.
shift

# Petla na wszystkich pozostalych parametrach.
while [[ $# -gt 0 ]]; do
  # Zapisujemy katalog docelowy kopiowania.
  cel_do_kopiowania="$1"
  # Sprawdzamy czy sciezka do kopiowania jest poprawna (is a
  # directory).
  if [[ -d $1 ]]; then
    # Kopiujemy.
    cp "$plik_do_kopiowania" "$cel_do_kopiowania"
  fi
  # Przesuwamy parametry.
  shift
done

exit 0
