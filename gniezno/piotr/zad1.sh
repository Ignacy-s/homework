#!/bin/bash

# Sun 29 Nov 2020 04:30:01 PM CET
# Piotr

# Napisać skrypt wyświetlający zawartość katalogu podanego jako
# pierwszy parametr wywołania. Jeśli parametr nie zostanie podany
# należy wyświetlić informacje o poprawnej składni polecenia.


# Sprawdz czy jest wiecej niz 0 parametrow
if [[ $# -ge 1 ]]; then
  ls  -la  "$1"
else
  echo "Podaj chociaż jeden argument będący lokalizacją."
  exit 1
fi

exit 0
