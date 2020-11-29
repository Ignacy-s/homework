#!/bin/bash

# Sun 29 Nov 2020 08:10:46 PM CET

# Wyświetl informacje o procesach użytkowników podanych jako kolejne
# wiersze w pliku będącym pierwszym parametrem wywołania. Informacje
# należy wyświetlić w dwóch kolumnach: nazwa użytkownika i PID
# procesu.

# Korzystamy z `man ps` i znajdujemy to:
# To see every process with a user-defined format:
# ps -eo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm
# ps axo stat,euid,ruid,tty,tpgid,sess,pgrp,ppid,pid,pcpu,comm
# ps -Ao pid,tt,user,fname,tmout,f,wchan

# Sprawdzić czy dostaliśmy jakieś parametry.
if [[ $# -eq 0 ]]; then
  echo "Brak parametrów."
  exit 1
fi

# Sprawdzić, czy plik w pierwszym parametrze nie istnieje.
if [[ ! -a "$1" ]]; then
  echo "Plik $1 nie istnieje."
  exit 1
fi

# Zapisać nazwę pliku.
plik_danych="$1"

# Pętla while read line do wykonania operacji na wszystkich linijkach z
# pliku.
while read uzytkownik ; do
  # Sprawdzamy czy uzytkownik istnieje badając exit code komendy id.
  if id "$uzytkownik" &>/dev/null; then
    # Uzywajac &>/dev/null przekierowywujemy wyjscie i wyjscie błędów
    # do /dev/null.
    # Wypisujemy aktywne procesy z wyszczególnionymi kolumnami: user
    # oraz pid.
    ps -ao user,pid | grep "$uzytkownik"
    # grepujemy linijki, w których jest nazwa naszego użytkownika.
  fi
done < "$plik_danych"
# Przekierowujemy nasz plik danych na wejście pętli.

exit 0
