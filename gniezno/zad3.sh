#!/bin/bash

# Wyświetl zawartość plików podanych jako kolejne parametry wywołania
# pod warunkiem że pliki te istnieją. Jeśli nie został podany żaden
# plik należy wyświetlić komunikat: „Nie ma czego wyświetlać”. Treści
# plików należy rozdzielić linią składającą się z samych gwiazdek.

# Sprawdzamy czy skrypt dostal zero argumentow.
if [[ $# -eq 0 ]]; then
  echo "Nie ma czego wyświetlać."
fi

# Pętla tak długo jak są elementy.
  # Sprawdzamy czy plik istnieje.
    # Jeśli plik istnieje, to go wypisujemy.
    # Oddzielamy treść pliku gwiazdkami.
