#!/bin/bash

# Napisać skrypt wyświetlający zawartość katalogu podanego jako
# pierwszy parameter wywołania. Jeśli parametr nie zostanie podany,
# należy wyświetlić informacje o poprawnej składni polecenia.


# Check if there is at least one argument.
if [[ $# -gt 0 ]]; then
  # Run ls with -la options to show what's in $1
  ls -la "$1" || {
    echo \
      "Błąd ls. Czy na pewno podałeś prawidłową lokalizację?"
    exit 1
  }
    # If ls returns an error, inform the user.  || means to run what's
    # after || only if the thing before fails.  \ backslash makes the
    # line continue into the next line. This way we can put echo and
    # it's message in separate lines and keep the script more readable
    # by not exceeding the standard 80 characters width.
    # { starts a codeblock. In this case || would normally allow only
    # one line to execute if ls fails. We want to execute two lines,
    # so we have to put them in a code block. This will make both of
    # them execute if ls fails.
else
  # Less than 1 argument given to the script.
  echo "Podaj chociaz jeden argument będący lokalizacją."
  exit 1
fi

exit 0

