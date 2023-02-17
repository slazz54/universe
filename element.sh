#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# if no value
if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    NUMBER=$1
    # get atomic by number
    AVAILABLE_ELEMENT=$($PSQL "SELECT pro.atomic_number FROM properties pro INNER JOIN elements el ON pro.atomic_number = el.atomic_number WHERE pro.atomic_number = $NUMBER")
  else
    CHARACTER=$1
    # get atomic by char
    AVAILABLE_ELEMENT=$($PSQL "SELECT pro.atomic_number FROM properties pro INNER JOIN elements el ON pro.atomic_number = el.atomic_number WHERE el.symbol = '$CHARACTER' OR el.name = '$CHARACTER'")
  fi

    # if no atomic  
  if [[ -z $AVAILABLE_ELEMENT ]]
  then
    echo -e "I could not find that element in the database."
  else
  # get element info
    ELEMENT_INFO=$($PSQL "SELECT pro.atomic_number, el.symbol, el.name, t.type, pro.atomic_mass, pro.melting_point_celsius, pro.boiling_point_celsius FROM properties pro INNER JOIN elements el ON pro.atomic_number = el.atomic_number LEFT JOIN types t ON pro.type_id = t.type_id WHERE pro.atomic_number ='$AVAILABLE_ELEMENT'")

    # view data element
    echo $ELEMENT_INFO | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT_CELCIUS BOILING_POINT_CELSIUS
    do
        echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELCIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done
  fi
fi
