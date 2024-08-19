#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=postgres --tuples-only -c"


echo $($PSQL "DROP DATABASE salon;")
echo $($PSQL "CREATE DATABASE salon;")
echo $($PSQL "\c salon")
echo $($PSQL "CREATE TABLE customers(customer_id SERIAL PRIMARY KEY, phone VARCHAR(12) UNIQUE, name VARCHAR(30));")
echo $($PSQL "CREATE TABLE appointments(appointment_id SERIAL PRIMARY KEY, customer_id INT, service_id INT, time VARCHAR(30), CONSTRAINT service_id FOREIGN KEY(customer_id) REFERENCES customers(customer_id),CONSTRAINT customer_id FOREIGN KEY(customer_id) REFERENCES customers(customer_id));")
echo $($PSQL "CREATE TABLE services(service_id SERIAL PRIMARY KEY, name VARCHAR(30));")
echo $($PSQL "INSERT INTO services(name) VALUES('Beard Trim'),('Moustache Trim'), ('Shave');")