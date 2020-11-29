#!/bin/bash

# Sun 29 Nov 2020 07:45:45 PM CET

# Napisz skrypt umożliwiający wykonanie trzech poleceń: who, ps ,
# ls. Wybór polecenia powinien odbywać się za pomocą menu.

# Prosimy o wybranie polecenia z menu:
echo "Wybierz polecenie z menu:"
echo "1. who"
echo "2. ps"
echo "3. ls"
# echo -n - bez przechodzenia do następnej linii.
echo -n "Twój wybór: "

# Wczytujemy cyfre wyboru w menu.
read cyfra_wyboru

# Wybieramy spośród kilku cyfr.
case $cyfra_wyboru in
  "cyfra_wyboru")
    echo "zapomniałeś $"
    ;;
  1)
    echo "Odpalam who"
    who
     ;;
  2)
    echo "Odpalam ps"
    ps
     ;;
  3)
    echo "Odpalam ls"
    ls
     ;;
  *)
    echo "Błąd wyboru: $cyfra_wyboru"
esac
