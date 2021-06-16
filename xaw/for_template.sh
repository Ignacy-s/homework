#!/bin/bash

# Example for using a `for` loop.
# Secrets and what the for loop iterates on is read from files in the
# execution directory of the script.

path_to_secrets="secrets"
path_to_dbs="dbs_list"

# # Populate secrets with variables defined in the secrets file.
# source "$path_to_secrets"

# echo "secret1 is ${secret1}."
# echo "secret2 is ${secret2}."

# Read db list from file, putting each line as a new element of the
# array. -t removes trailing newline from each line.
mapfile -t db_names < "$path_to_dbs"
mapfile -t db_secrets < "$path_to_secrets"

# Iterate over all elements of the array.
for db_name in "${db_names[@]}"; do
  echo "db_name is now ${db_name}."
done

# List some info on array.
echo "Number of elements in db_names is ${#db_names[@]}".

count_of_dbs="${#db_names[@]}"
for (( i=0 ; i < count_of_dbs ; i++ )); do
  echo "Nr $i in db_names is ${db_names[$i]}."
  echo "Nr $i in db_secrets is ${db_secrets[$i]}."
done

exit 0

