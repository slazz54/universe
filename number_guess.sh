#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c" 
echo -e "Enter your username:"
read USERNAME

# check username
AVALIABILITY_USERNAME=$($PSQL "SELECT username FROM username WHERE username='$USERNAME'")

# count game per username
GAME_PLAYED_INFO=$($PSQL "SELECT COUNT(*) FROM number_guess ng INNER JOIN username un ON ng.username_id = un.username_id WHERE un.username = '$USERNAME'")
if [[ -z $GAME_PLAYED_INFO ]]
then
  $GAME_PLAYED_INFO=0
fi

# minimum guess number game per username
MINIMUM_GUESS_INFO=$($PSQL "SELECT MIN(number_of_tries) FROM number_guess ng INNER JOIN username un ON ng.username_id = un.username_id WHERE un.username = '$USERNAME'")

if [[ -z $AVALIABILITY_USERNAME ]]
then
  # insert username table
  INSERT_USERNAME_RESULT=$($PSQL "INSERT INTO username(username) VALUES('$USERNAME')")
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  $GAME_PLAYED_INFO=0
else
  # user existing
  echo -e "\nWelcome back, $AVALIABILITY_USERNAME! You have played $GAME_PLAYED_INFO games, and your best game took $MINIMUM_GUESS_INFO guesses."
fi


# get username id
GET_USERNAME_ID=$($PSQL "SELECT username_id FROM username WHERE username='$USERNAME'")

# generate random number
RANDOM_NUMBER=$(( RANDOM % 1000 ))

# function for show message if user input number or character
function GET_GUESS_NUMBER() {
  if [[ ! $1 ]]
  then
    echo -e "Guess the secret number between 1 and 1000:"
  else
    echo -e "That is not an integer, guess again:"
  fi
  # input number
  read NUMBER

}
GET_GUESS_NUMBER
# check if user input character or number
until [[ $NUMBER =~ ^[0-9]+$ ]]
do
  GET_GUESS_NUMBER again
done

# add function for condition number < generate number or number > generate number
function GET_NUMBER_RESULT() {
  if [[ $NUMBER -ge $RANDOM_NUMBER ]]
  then
    echo -e "\nIt's lower than that, guess again:"
  else [[ $NUMBER -le $RANDOM_NUMBER ]]
    echo -e "\nIt's higher than that, guess again:"
  fi
  read NUMBER
}
GET_NUMBER_RESULT

NUMBER_TRIES=2

# check if number input by user & generate number same
until [[ $NUMBER == $RANDOM_NUMBER ]]
do
  GET_NUMBER_RESULT again

  NUMBER_TRIES=$((NUMBER_TRIES+1))
  
done

if [[ $NUMBER == $RANDOM_NUMBER ]]
then
   echo -e "\nYou guessed it in $NUMBER_TRIES tries. The secret number was $RANDOM_NUMBER. Nice job!"
   INSERT_GUESS_NUMBER_RESULT=$($PSQL "INSERT INTO number_guess(username_id, number_guess, number_of_tries) VALUES($GET_USERNAME_ID, $NUMBER, $NUMBER_TRIES)")
fi
