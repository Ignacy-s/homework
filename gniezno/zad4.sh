#!/bin/bash

# Sun 29 Nov 2020 06:30:34 PM CET

# Napisać skrypt który sprawdzi czy wszystkie pliki podane jako
# kolejne parametry wywołania istnieją. Jeśli wszystkie pliki istnieją
# należy wyświetlić komunikat „Wszystkie podane przez Ciebie pliki
# istnieją” a jeśli choćby jednego pliku brakuje to należy wyświetlić
# komunikat „Lista podanych plików jest niekompletna”.

# Sprawdzamy czy skrypt dostal zero argumentow.
if [[ $# -eq 0 ]]; then
  echo "Pusta lista argumentów."
  exit 1
fi

# Pętla tak długo jak są elementy.
until [[ $# -eq 0 ]]; do
  # Sprawdzamy czy plik nie istnieje.
  if [[ ! -a "$1" ]]; then
    # Jeśli plik nie istnieje.
    echo "Lista podanych plików jest niekompletna"
    exit 1
  fi
  shift
done

# Pętla nie wykryla braku zadnego pliku, wiec wszystkie istnieja.
echo "Wszystkie podane przez Ciebie pliki istnieją"
exit 0
