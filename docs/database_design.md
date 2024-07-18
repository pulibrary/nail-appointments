# Nail Appointments Database

## Tables
1. Users: This will store the basic information of users, additional login information, and the role of users (admin, customer, etc). This will allow for an appointment to be connected to a specific user and login functionality. Complete information about appointments will be restricted to the administrator.
2. Availability: This will store the times available for an appointment.
3. Appointments: This will connect the user and timeslot the user chose for the appointment. Additional information that the user has provided about their requests for the appointment will be stored in this table.

## Table Columns and Contents
*Note: Rails already provides a column for the ID*

### users
* **id (INT Primary Key)**
* **first_name (VARCHAR)**
* **last_name (VARCHAR)**
* **pronouns (VARCHAR)**
* **email (VARCHAR)**
* **password (VARCHAR)**
* **role (INT)**

### availability
* **id (INT Primary Key)**
* **start_time (TIMESTAMP)**
* **end_time (TIMESTAMP)**
* **filled_status (BOOLEAN)**

### appointments
* **id (INT Primary Key)**
* **user_id (INT) REFERENCES users.id**
* **availability_id (INT) REFERENCES availability.id**
* **service (VARCHAR)**: Records the type of service requested (ex: Manicure, Pedicure, etc)
* **comments (VARCHAR)**: Records any additional comments/requests by customer.


## Sample Queries
1. INSERT INTO appointments VALUES(NULL, 1, 4, 'Manicure', 'Gel Polish Requested');
2. DELETE FROM appointments WHERE user_id = 1 AND availability_id = 4;
3. UPDATE availability SET filled_status = TRUE WHERE id = 4;
