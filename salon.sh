#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services;")

 #echo "How may I help you?" 
 echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
done
     # ask for service
#    echo -e "\nWhich service"
	read SERVICE_ID_SELECTED
# if input is not a number
    if [[ ! $SERVICE_ID_SELECTED =~ ^[1-3] ]]
    then
      # send to main menu
      MAIN "I can't find that service. Please try again.\n"
    else
    	echo -e "Enter your phone in the format xxx-xxx-xxxx"
	read CUSTOMER_PHONE

	#If a phone number entered doesn’t exist, you should get the customers name and enter it, and the phone number, into the customers table
	CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")

  # echo "Customer ID is $CUSTOMER_ID"

  if [[ -z $CUSTOMER_ID ]]
  then
    # send to main menu
    echo "Welcome new customer!"
    echo -e "Enter your Name"
	  read CUSTOMER_NAME
    INSERT_RESULT=$($PSQL "INSERT into customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME');")
	fi

	CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

	echo -e "Enter your Time"
	read SERVICE_TIME
	
	INSERT_RESULT=$($PSQL "INSERT into appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME');")
  
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")
	SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  
  if [[ $INSERT_RESULT=='INSERT 0 1' ]]
  then
    echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME,$CUSTOMER_NAME.";
  fi
	fi


}
MAIN "\n~~~~~ Salon Shop ~~~~~\n"