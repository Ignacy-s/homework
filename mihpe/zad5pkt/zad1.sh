#!/bin/bash

# 1. Napisz skrypt, który wypisze liczbę wszystkich plików w tych
# katalogach z katalogu podanego jako argument, w których są
# przynajmniej trzy pliki z rozszerzeniem exe, które można uruchomić,
# ale których nazwy nie są palindromami (Palindrom, wyraz, który tak
# samo brzmi od tyłu jak i od przodu np.: kajak).

# Sun 23 May 2021 02:38:42 PM CEST


# Skrypty na linuxie zaczynami hashbangiem (#!) po czym dajemy ściężkę
# do interpretera, programu wykonującego skrypt linijka po
# linijce. Dla skryptu pythonowego byłby to #!/bin/python, dla
# rubowego chyba #!/bin/ruby a dla bash jak widzisz.

# Zaraz po hashbangu piszemy krótko co robi skrypt. W przypadku takich
# zadań można wkleić treść zadanka. Kiedy piszesz jakiś prosty skrypt
# dla siebie, (bo np zauważyłeś, że zawsze jak wysyłasz sprawozdanie z
# zajęć to po prostu pakujesz wszystkie rzeczy w folderze poza tymi z
# rozszerzeniem .out i chcesz sobie ułatwić życie na następny raz,) to
# piszesz na górze jaki jest zamiar.

# Celem komentarza wyjaśniającego co robi skrypt na górze jest
# ułatwienie utrzymania porządku w skryptach, ułatwienie zrozumienia
# tego co robi skrypt pół roku później po tym jak go napisałeś oraz
# ułatwienie zrozumienia tego co chciałeś zrobić, kiedy pokazujesz
# skrypt komuś w internecie, bo coś w nim nie działa i nie rozumiesz
# dlaczego.

# Ważne: Szukanie pomocy.
# W skryptach będziesz używać różnych narzędzi takich jak tar, cat,
# read, echo. Część z nich to samodzielne programy, część to wbudowane
# funkcje bash, tzw SHELL BUILTINS. Nikt kto używa konsoli nie pamięta
# jak ich używać i każdy pomaga sobie manualami lub pomocami. Manuali
# używa się tak: `man cat` i działają z programami na linuxie. Komendy
# help używa się z bash builtins i robi się to tak: "help echo". Na
# temat builtinsów można przeczytać więcej w manualu do programu
# bash. Odpalisz go pisząc `man bash`. Wewnątrz manuali poruszasz się
# strzałkami, spacją, a wyszukujesz rzeczy pisząc forward_slash FRAZA,
# czyli wewnątrz manuala piszesz `/FRAZA`. Jeżeli wyników wyszukiwania
# jest więcej niż jeden, to do następnego przejdziesz małym `n`, a do
# poprzedniego dużym `N` czyli n z shiftem.
# Co jest builtinem, a co programem? Dowiesz się używając builtina
# `type`. Np. teraz, żeby sprawdzić czy `type` to builtin czy
# executable (program) wpisałem w konsoli `type -a type`. -a pokaże
# wszystkie możliwości, czasem jakaś nazwa ma wiele znaczeń.


## 1. Napisz skrypt, który wypisze liczbę wszystkich plików w tych
## katalogach z katalogu podanego jako argument, w których są
## przynajmniej trzy pliki z rozszerzeniem exe, które można uruchomić,
## ale których nazwy nie są palindromami (Palindrom, wyraz, który tak
## samo brzmi od tyłu jak i od przodu np.: kajak).

# To zadanie jest w miarę złożone, a ja dzisiaj nie jestem w orlej
# formie, więc rozrysuję sobie to jako schemat blokowy, żeby upewnić,
# że moja logika wykonania zadania trzyma się kupy.

# Uwaga, nieprecyzyjna treść zadania. Najpierw mowa o rozszerzeniach,
# potem o nazwie, ale nie jest powiedziane, czy rozszerzenie jest
# częscią nazwy. Na wszelki wypadek przy sprawdzaniu czy nazwa jest
# palindromem jednak usuniemy część nazwy która jest rozszerzeniem.

set +x

ROOT_DIR="$1"

echo "Root dir is: $ROOT_DIR"

# Zapisujemy zawartość pierwszego argumentu skryptu $1 jako
# ROOT_DIR. Dzięki temu ma sensowną nazwę, której później będziemy
# używać. Kod będzie czytelniejszy.

# Praktycznie zawsze gdy używamy zmiennych w bash, trzeba je wrzucić w
# cudzysłów, żeby uniknąć problemów gdyby np pierwszy argument
# zawierał w sobie spacje albo inne rzeczy, które bash mógłby w tym
# momencie inaczej zinterpretować. Shellcheck zgłasza w przypadku nie
# wzięcia stringu w cudzysłów taki błąd:
# Double quote to prevent globbing and word splitting. [SC2086]

# Jeżeli używasz vim, to po napisaniu kawałka skryptu powinieneś go
# minimalizować i odpalać na nim shellcheck, to znaczy, napisać w
# linii komend `shellcheck nazwa_skryptu.sh`. W ten sposób możesz na
# bierząco wiedzieć czy nie robisz jakichś łatwych do wychwycenia
# błędów. W emacsie ustawiasz go tak:
# http://www.skybert.net/emacs/bash-linting-in-emacs/

# Teraz możesz spojrzeć na diagram do zadania. Wynika z niego, że
# potrzebujemy do zadania dwóch pętli. W pierwszej iterujemy po każdym
# folderze w naszym folderze głównym.

# Gdybyśmy byli w konsoli, a nie pisali skrypt, to wypisalibyśmy sobie
# pliki używając `ls`. Ale w skryptach nie używa się `ls` bo nie można
# na nim polegać, więc używamy `find`. Znajduje się na końcu naszej
# pętli, za słówkiem `done` które jest odpowiednikiem klamerki
# zamykającej blok kodu pętli w języku z rodziny C.

# Pętla while będzie wykonywać się tak długo jak `read` będzie w stanie
# wczytać nową linijkę do zmiennej o nazwie `DIR`. Tak w bashu
# iterujemy na dłuższych listach. Read służy do takich rzeczy.
while read DIR ; do
  echo "$DIR"
done < "$(find "$ROOT_DIR" -maxdepth 1 -type d)"



# Testowanie skryptu:
# for ((i=1;i<6;i++)) ; do cd ${i}dir; for (( x=1 ; x<6 ; x++)) ; do touch ${x}file; if [[ $i -lt $x ]]; then chmod +x ${x}file; fi; done; cd .. ; done;
# Ta linijka stworzy nam w aktualnej lokalizacji małe poletko do testów.
