#!/bin/bash                                                                 

# $( grep -0 "[[:digit:]]" "$file" | wc -l ) -> count digits                
# file_name="${file_name##*/}" -> cut out path                              
# file_extension="${file_name##*.}" -> cut out extension                    
# name_minus_ext="${file_name%.file_extension}"                             

for DIR in "$@" ; do                                                        
  if ! [[ ( -d "$DIR" ) ]] ; then                                         
    echo "$DIR is not a directory"                                      
  fi                                                                      
done                                                                        

vowel_words=0                                                               

for DIR in "$@" ; do                                                        
  cd "$DIR" || exit 1;                                                              
  while read file_name ; do  
    #echo "$file_name"                                                  
    while read -r line ; do                                             
      for word in $line ; do  # Jezeli $line nie bedzie w
	# cudzyslowie, to rozlosy sie na slowa skladowe.
        character_count=$(wc -m <<< "$word")                     
#        (( character_count-- ))
        echo "$word -> $character_count"                            
        
        if [[ $(( character_count % 2 )) -eq 0 ]] ; then            
          
          if echo "$word" | grep -q "^[aeiouyAEIOUY].*" ; then    
            #               echo "$word"                                        
            (( vowel_words++ ))                                 
          fi                                                      
        fi                                                          
      done                                                            
    done < "$file_name"                                                 
  done < <( find . -maxdepth 1 -type f)                                   
  cd ..                                                                   
done                                                                        

echo "Words matching criteria count $vowel_words"                           
exit 0       
