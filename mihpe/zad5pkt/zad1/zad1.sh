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

#set -x
# set -x sprawi, że w czasie wykonywania skryptu dowiemy się o
# wszystkim co robi skrypt, nawet o wykonanych komendach, które
# normalnie nic nie wypisują na ekran. Przydaje się w czasie
# testowania skryptu, żeby wiedzieć co poszło nie tak.

ROOT_DIR="$1"

# Exit on fail.
die(){
  # Funkcja die to sposób w jaki radzimy sobie z błędami w
  # skrypcie. Ta funkcja zwraca informacje o błędzie na STDERR i
  # zatrzymuje działanie programu. Dzięki temu jeżeli nie uda nam się
  # np. zmienić lokalizacji, program nie będzie dalej wykonywać się w
  # złym miejscu, siejąc chaos i zniszczenie.
  # Używamy jej tak: `die "Nie mozna otworzyc pliku X."`
  
  error_msg="${*}"
  # "$* albo ${*} to po prostu wszystkie parametry podane do funkcji
  # wypisane razem. Ta zmienna nie jest potrzebna, można było
  # patametry przekazać od razu do późniejszego `echo`, ale dzięki
  # nazwaniu ich w zmiennej przekazujemy informacje o tym co robi
  # funkcja komuś kto ją będzie później czytał.
  
  echo -e "Error: $error_msg" >&2
  # `echo` wypisuje to co dostanie jako argument/y. Opcja -e sprawi,
  # że możemy użyć tzw. escape sequences. Ich listę można zobaczyć
  # wpisując w konsoli `help echo`. Dzięki temu do `die` można podać
  # string z tabami albo ze znakami nowej linii.
  # $error_msg podstawia w swoje miejsce zawartość zmiennej
  # error_msg.
  # >&2 przkierowuje wyjście komendy echo. Normalnie wypisałaby na
  # STDIN, standardowe wyjście (1), ale komunikaty o błędach konwencja
  # nakazuje wypisywać na STDERR. STDERR to 2. >& przekierowuje
  # wyjście na konkretny strumień, w tym wypadku strumień drugi czyli
  # STDERR.
  
  echo "Exiting $0." >&2
  # $0 to specjalny parametr, który zawiera w sobie nazwę naszego
  # programu tak jak został wywołany. Jeżeli skrypt odpalisz
  # ./nazwa.sh to to będzie w $0. Jeżeli miał inną nazwę, alias albo
  # użyłeś pełnej ścieżki, to to będzie w $0. W ten sposób możemy
  # poinformować użytkownika jaki program zamknęliśmy, nawet jeżeli
  # nie wiemy jak program się nazywa w momencie pisania komunikatu o
  # błędzie.
  
  exit 1
  # exit 1 zamyka program (cały, nie tylko funkcję) zwracając 1, który
  # jest kod błędu. Jeżeli ktoś użyje naszego skryptu w innym
  # skrypcie, będzie mógł ten błąd "wychwycić" i odpowiednio
  # zareagować, np. zamykając swój program.
}


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
# iterujemy na dłuższych listach. Read służy do wczytywania danych do
# zmiennych, domyślnie czyta ze STDIN takich rzeczy. O tym jak
# działają strumienie możesz przeczytać w
# https://mywiki.wooledge.org/BashGuide/InputAndOutput
# Pod hasłem File Descriptors.

cd "$ROOT_DIR" \
  || die 'cd "$ROOT_DIR"'

while read DIR ; do
# while to pętla, która działa tak długo jak wyrażenie za while jest
# prawdziwe. Wyrażeniem może być conditional typu [[, albo
# jakiekolwiek inne polecenie. Każde polecenie/program w bashu coś
# zwraca. I jeżeli to co zwraca to 0 (OK) to while działa dalej, aż
# wyjdzie coś innego niż 0.
  cd "$DIR" \
    || die 'cd "$DIR"'
  GOOD_FILES=0
  # Zmienna do pamiętania ile mamy plików spełniających warunki .exe,
  # bycia wykonywalnym i nie bycia palindromem.
  while read FILE_NAME; do
    FILE_NAME="${FILE_NAME##*/}"
    # Używamy `parameter expansion` żeby wyciąć potrzebną nam część
    # z nazwy pliku. Najpierw FILE_NAME ma treść ./2file.exe lub
    # ./test/2file.exe. Parameter expansion może wyciąć część
    # zawartości parametru albo wypisać tylko jedną z jego liter albo
    # jego długość. W przypadku # kasujemy z początku lub w przypadku
    # % z końca to co pasuje do patternu podanego po %/#. Jeżeli
    # użyjemy jednego #/% to kasujemy najkrótszy pasujący kawałek
    # treści. Jeżeli ##/%% to najdłuższy. Gwiazdka `*` pasuje do
    # wszystkiego, a po niej jest slash `/`. Czyli ${FILE_NAME##*/}
    # znaczy "Z zawartości zmiennej FILE_NAME skasuj najdłuższy
    # mozliwy fragment, który można opisać patternem `*/`. Czyli z
    # pełnej ścieżki do pliku otrzymamy samą nazwę pliku. O parameter
    # expansion możesz poczytać w Bash Wiki
    # https://mywiki.wooledge.org/BashGuide/Parameters
    # albo w `man bash` wyszukując ze slashem `/parameter expansion`
    # (pamiętaj, że `n` skacze do następnego wyniku wyszukiwania). Z
    # przykładami możesz zobaczyć to tutaj (właśnie samo wyłuskiwanie
    # rozszerzeń itp:
    # https://www.cyberciti.biz/faq/unix-linux-extract-filename-and-extension-in-bash/
    

    FILE_EXTENSION="${FILE_NAME##*.}"
    # Tak jak wyżej, wycinamy wszystko przed kropką, nawet jeżeli
    # gdzieś w nazwie pliku jest jeszcze jedna kropka (jeden #
    # zostawiłby wszystko po pierwszej kropce, nawet jeżeli nie byłoby
    # to rozszerzenie).

    NAME_MINUS_EXT="${FILE_NAME%.$FILE_EXTENSION}"
    # Teraz usuwamy z końca, ale tylko do pierwszej kropki. Usuwamy
    # rozszerzenie, które właśnie odkryliśmy.

    REVERSE_NAME="$( rev <<< $NAME_MINUS_EXT )"
    # $( .. ) to Command Substitution.
    # https://mywiki.wooledge.org/CommandSubstitution
    # W miejsce w którym jest $() bash najpierw podstawi to co zwróci
    # komenda w środku, a z tak uzyskanymi informacjami wykona resztę
    # komendy, czyli przypisanie. Innymi słowy znaczy to, żeby to
    # reverse name wpisać to co wyjdzie po wykonaniu komendy w środku.
    # `rev` to program, który wypisze od końca każdą linijkę podanego
    # pliku. Wymaga pliku i nie może działać ze
    # stringiem/zmienną. Żeby go oszukać użyjemy <<< czyli
    # HERE STRING. <<< stworzy tymczasowy plik o zawartości tego co mu
    # podamy (czyli naszej zmiennej) i ten tymczasowy plik poda do
    # `rev`. O HERE STRINGS i HERE DOCS poczytasz w manualu basha `man
    # bash` `/here docs` albo w bash wiki w kawałku na temat
    # wejścia/wyjścia 4.3 Heredocs And Herestrings:
    # https://mywiki.wooledge.org/BashGuide/InputAndOutput

    # Z tak przygotowanymi zmiennymi możemy wykonać 3 porównania, żeby
    # sprawdzić, czy plik spełnia nasze wymagania. Używamy instrukcji
    # warunkowej if oraz [[, z trzema połączonymi warunkami. Pomoc do
    # nich pod `help if` oraz `help [[` oraz wewnątrz `man bash`. Sam
    # do nich zaglądałem przy pisaniu, żeby się nie pomylić.
    if [[ ( $FILE_EXTENSION = .exe ) \
      # = to zwykłe porównanie stringów. O tym jakich porównań możesz
      # użyć z [[ sprawdzisz w `help [[`.
            && ( -x $FILE_NAME ) \
              # linia zakończona backslashem \ się nie kończy, tylko
              # notynuuje w następnej linijce. Dzięki temu można
              # rozdzielić te kilka warunków na 3 linijki i zachować
              # więcej czytelności. && służy wewnątrz [[ ]] do
              # "łączenia" różnych warunków, logiczny `and`. || to
              # logiczny `or`. W innej części skryptu `&&` i `||`
              # oznaczają co innego.
            && ( $NAME_MINUS_EXT != "$REVERSE_NAME" ) ]]; then
      (( GOOD_FILES++))
      # $(( to mathematical expansion. W środku $(( nie trzeba dodawać
      # $ przed nazwami zmiennych a znaki działania wykonują
      # działania. Gdyby przed (( był znak dolara, to w to miejsce
      # wstawiony byłby wynik działania. My jednak nie potrzebujemy
      # wyniku, chcemy tylko zwiększyć zawartość good files.
    fi
  done < <( find . -maxdepth 1 -type f)
  if [[ $GOOD_FILES -ge 3 ]]; then
    echo "zostało wypisać w tym miejscu ile plikow ma folde."
  fi
  
  cd .. \
    || die 'cd ..'
done < <( find . -maxdepth 1 -type d | tail -n +2 )


# Testowanie skryptu:
# for ((i=1;i<6;i++)) ; do cd ${i}dir; for (( x=1 ; x<6 ; x++)) ; do touch ${x}file; if [[ $i -lt $x ]]; then chmod +x ${x}file; fi; done; cd .. ; done;
# Ta linijka stworzy nam w aktualnej lokalizacji małe poletko do testów.
