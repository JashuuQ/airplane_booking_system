## Flight Booking System

This project is an Flight Booking System designed to provide users with a convenient platform for booking, managing flights, and handling ticket-related operations. The system leverages a SQL-based database for structured data storage and integrates with a Java-based front-end application.


---

### Features

- **Flight Search:** Find available flights based on criteria.
- **Booking Management:** Confirm bookings, view details, request cancellations, or change flights.
- **User-Centric Interface:** Simplifies access to essential booking details.

---
### Prerequisites

To build and run this project, the following software and tools are required:

1. **Software**
   - **IDE:** [IntelliJ IDEA](https://www.jetbrains.com/idea/) (recommended)
   - **Database Client:** [MySQL Workbench](https://dev.mysql.com/downloads/workbench/)
   - **Containerization:** [Docker](https://www.docker.com/products/docker-desktop) (optional for deployment)

2. **Libraries and Frameworks**
   - ****Java JDK**
   - [Spring Framework](https://spring.io/)
   - **JDBC** for database connectivity
   - **Swing** for graphical user** interface development

3. **Database**
   - **MySQL Community Server** version 8.0 or later.
   - JDBC driver for MySQL ([Download](https://dev.mysql.com/downloads/connector/j/)).

4. **Operating System**
   - macOS (project developed and tested on macOS).

---

### Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/JashuuQ/airplane_booking_system.git
   cd airplane_booking_system
   ```

2. **Install Required Software**
    Ensure the following software is installed on your computer:
    - IntelliJ IDEA
    - MySQL Community Server
    - MySQL Workbench

3. **Configure the Database**

   1. Start MySQL Server: Open MySQL Workbench and connect to your local MySQL server.
      
   2. Create a New Database: Create a database schema using the provided SQL file `bs_airplane_booking.sql`:
      
   3. Set Up Database Connection**:
      Update the following fields with your MySQL credentials:
      ```properties
        spring.datasource.url=jdbc:mysql://localhost:3306/bs_airplane_booking
        spring.datasource.username=root
        spring.datasource.password=qianjiashu
      ```

   4. Install Dependencies: Ensure that Maven (or Gradle) is configured in your IDE.
   
4. **Run the Application**
   - Locate the `LoginView.java` file in the code/view directory.
   - Right-click on the `LoginView.java` file and select Run `Main.main()` to start the application.
  
---

### Test Application

- After the application starts, interact with the GUI to test functionalities:
  - Login: Use the following credentials to log in:
     - Admin user:
       - Username: `admin`
       - Password: `test123`
     - Regular user:
       - Username: `user`
       - Password: `test123`
  - Search Flights: Enter search criteria and view available flights.
  - Book Flights: Select a flight and confirm booking.
  - Manage Bookings: Request cancellation or modification of bookings.

- **Demo showcases**

| Feature                | Image                              |
|------------------------|-------------------------------------|
| Login                  | ![Login](/code/img/login.jpg)      |
| Search All Flights     | ![SearchAll](/code/img/SearchAll.jpg) |
| Search Specific Flight | ![SearchOne](/code/img/SearchOne.jpg) |
| Create Booking         | ![Create](/code/img/Create.jpg)    |
| Delete Booking         | ![Delete](/code/img/Delete.jpg)    |
| Update Booking         | ![Update](/code/img/Update.jpg)    |


<div align="center" style="box-shadow: 0px 4px 1px rgba(0, 0, 0, 0.1); padding: 10px 20px; border-radius: 10px; margin-top: -10px;">
👤 Created by: Jashuu.Q | December, 2024
</div>



