#! /bin/bash

echo -e "\n~~~~ My Salon ~~~~\n"

#) service
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only --command"

SERVICE_LIST() {

if [[ $1 ]]
then
  echo -e "\nI could not find that service. What would you like today?"  
else
  echo -e "\nWelcome to My Salon, how can I help you?"
fi


# get service
SERVICE=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

# if no service
if [[ -z $SERVICE ]]
then
  # get service
  SERVICE_LIST "No service available."
else
  echo "$SERVICE" | while read SERVICE_ID BAR NAME
    do
      echo -e "$SERVICE_ID) $NAME"
    done
    read SERVICE_ID_SELECTED
fi

case $SERVICE_ID_SELECTED in
  1) ORDER ;;
  2) ORDER ;;
  3) ORDER ;;
  4) ORDER ;;
  5) ORDER ;;
  6) EXIT ;;
  *) SERVICE_LIST "I could not find that service. What would you like today?" ;;
esac
}

ORDER () {
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  
  # check phone number
  CHECK_NAME_CUSTOMER=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE' ORDER BY customer_id")

    # if not customer
  if [[ -z $CHECK_NAME_CUSTOMER ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")

    if [[ $INSERT_CUSTOMER_RESULT == "INSERT 0 1" ]]
    then
      echo -e "\nInsert to customers, $CUSTOMER_PHONE $CUSTOMER_NAME"
    fi
  else
    # get existing customer
    EXISTING_CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  fi

  # ask time customer
  if [[ -z $EXISTING_CUSTOMER_NAME ]]
  then
    echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
    read SERVICE_TIME
  else
    echo -e "\nWhat time would you like your cut, $EXISTING_CUSTOMER_NAME?"
    read SERVICE_TIME
  fi
  
  # get customer
  CUSTOMER_ID_RESULT=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if customer existing
  if [[ -z $EXISTING_CUSTOMER_NAME ]]
  then
  # insert appointments customer
    APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID_RESULT, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    if [[ $APPOINTMENT_RESULT == "INSERT 0 1" ]]
    then
      # get service
      SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id =$SERVICE_ID_SELECTED")

      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  else
     # insert appointments customer
    APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID_RESULT, $SERVICE_ID_SELECTED, '$SERVICE_TIME'), ($CUSTOMER_ID_RESULT, 2, '$SERVICE_TIME')")
    if [[ $APPOINTMENT_RESULT == "INSERT 0 2" ]]
    then
      # get service
      SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id =$SERVICE_ID_SELECTED")

      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $EXISTING_CUSTOMER_NAME."
    fi
  fi
}


EXIT () {
  echo -e "\nThank you for coming.\n"
}

SERVICE_LIST
