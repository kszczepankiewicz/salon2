#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"
SHOW_SERVICES () {
  if [[ "$1" ]]; then
    echo "$1"
  fi
  SERVICES=$($PSQL "SELECT * FROM services")
  echo "Choose service:"
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME; do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  read CHOSEN_SERVICE
  RESULT=$($PSQL "SELECT * FROM services WHERE service_id = $CHOSEN_SERVICE")
  echo $RESULT
}
SHOW_SERVICES
while [[ -z $RESULT ]]; do
  SHOW_SERVICES "Choose valid service"
done

echo "Enter your phone number:"
read CUSTOMER_PHONE
RESULT=$($PSQL "SELECT * FROM customers WHERE phone = '$CUSTOMER_PHONE'")
if [[ -z $RESULT ]]; then
  echo "Enter your name:"
  read CUSTOMER_NAME
  INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  echo "Inserted: $CUSTOMER_NAME"
fi
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
echo "Enter service id:"
read SERVICE_ID_SELECTED
echo "Enter time:"
read SERVICE_TIME


