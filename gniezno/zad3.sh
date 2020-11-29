#!/bin/bash

# Sun 29 Nov 2020 06:28:53 PM CET

# Wyświetl zawartość plików podanych jako kolejne parametry wywołania
# pod warunkiem że pliki te istnieją. Jeśli nie został podany żaden
# plik należy wyświetlić komunikat: „Nie ma czego wyświetlać”. Treści
# plików należy rozdzielić linią składającą się z samych gwiazdek.

# Sprawdzamy czy skrypt dostal zero argumentow.
if [[ $# -eq 0 ]]; then
  echo "Nie ma czego wyświetlać."
fi

# Zmienna z gwiazdkam.
gwiazdki="********************************************************************************"
# Pętla tak długo jak są elementy.
until [[ $# -eq 0 ]]; do
  # Sprawdzamy czy plik istnieje.
  if [[ -a "$1" ]]; then
    # Jeśli plik istnieje, to go wypisujemy.
    cat "$1"
    # Oddzielamy treść pliku gwiazdkami.
    echo "$gwiazdki"
  fi
  shift
done
