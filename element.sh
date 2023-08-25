#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 ]] # check whether there is an argument
then 
  if [[ $1 =~ ^[0-9]+$ ]]
  then 
    ATOMIC_NO=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1 OR symbol='$1' OR name='$1'")
    if [[ -z $ATOMIC_NO ]]
    then
      echo "I could not find that element in the database."
    else
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NO")
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NO")
      TYPE=$($PSQL "SELECT type FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NO")
      MASS=$($PSQL "SELECT atomic_mass FROM elements LEFT JOIN properties USING(atomic_number) WHERE atomic_number=$ATOMIC_NO")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) WHERE atomic_number=$ATOMIC_NO")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) WHERE atomic_number=$ATOMIC_NO")
      echo -e "The element with atomic number $(echo $ATOMIC_NO | sed -r 's/^ *| *$//g') is $(echo $NAME | sed -r 's/^ *| *$//g') ($(echo $SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -r 's/^ *| *$//g') amu. $(echo $NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $MELTING_POINT | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING_POINT | sed -r 's/^ *| *$//g') celsius." 
    fi
  elif [[ ! $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NO=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
    if [[ -z $ATOMIC_NO ]]
    then
      echo "I could not find that element in the database."
    else
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NO")
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NO")
      TYPE=$($PSQL "SELECT type FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NO")
      MASS=$($PSQL "SELECT atomic_mass FROM elements LEFT JOIN properties USING(atomic_number) WHERE atomic_number=$ATOMIC_NO")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) WHERE atomic_number=$ATOMIC_NO")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) WHERE atomic_number=$ATOMIC_NO")
      echo -e "The element with atomic number $(echo $ATOMIC_NO | sed -r 's/^ *| *$//g') is $(echo $NAME | sed -r 's/^ *| *$//g') ($(echo $SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $MASS | sed -r 's/^ *| *$//g') amu. $(echo $NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $MELTING_POINT | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING_POINT | sed -r 's/^ *| *$//g') celsius." 
    fi
  else echo "I could not find that element in the database."
  fi
else
  echo Please provide an element as an argument.
fi