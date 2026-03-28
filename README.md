# 💼 Employee Payroll System

A **Java Web Application** built using **Servlets, JSP, JDBC, and MySQL** that allows users to manage employee payroll data efficiently.

---

## 🚀 Features

* ➕ Add Employee
* 🗄 Store employee data in MySQL database
* 🔗 JDBC integration
* 🌐 Web-based interface using JSP & Servlets
* 🎨 Basic UI with Bootstrap

---

## 🛠 Tech Stack

* **Backend:** Java (Servlets, JSP)
* **Database:** MySQL
* **Connectivity:** JDBC
* **Frontend:** HTML, CSS, Bootstrap 5
* **Server:** Apache Tomcat 10
* **IDE:** Apache NetBeans

---

## 📂 Project Structure

```
EmployeePayrollSystem/
│
├── src/
│   ├── com.payroll.model        # Entity classes (Employee)
│   ├── com.payroll.dao          # Database operations (DAO)
│   ├── com.payroll.controller   # Servlets (Controller)
│
├── web/
│   ├── views/                   # JSP Pages
│   ├── WEB-INF/
│   │   └── web.xml              # Deployment descriptor
│   └── index.jsp                # Home page
```

---

## ⚙️ Setup Instructions

### 1️⃣ Clone Repository

```
git clone https://github.com/your-username/EmployeePayrollSystem.git
```

---

### 2️⃣ Import Project

* Open **Apache NetBeans**
* Click **File → Open Project**
* Select the project folder

---

### 3️⃣ Setup MySQL Database

Run the following SQL:

```sql
CREATE DATABASE payroll_db;

USE payroll_db;

CREATE TABLE employee (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(50),
    salary DOUBLE
);
```

---

### 4️⃣ Configure Database Connection

Update credentials in:

```
DBConnection.java
```

```java
jdbc:mysql://localhost:3306/payroll_db
username: root
password: your_password
```

---

### 5️⃣ Add MySQL Connector

* Download MySQL Connector/J
* Add `.jar` file to project libraries

---

### 6️⃣ Run the Project

* Right click project → **Run**
* Open browser:

```
http://localhost:8080/EmployeePayrollSystem/
```

---

## 📸 Screenshots

* Home Page
 <img width="1889" height="899" alt="image" src="https://github.com/user-attachments/assets/104fc5a4-76f2-4673-9577-2c36a0e5773a" />

* Add Employee Form
  <img width="1868" height="899" alt="image" src="https://github.com/user-attachments/assets/bb087cd8-8372-4203-b648-b7bfb4cdd6ac" />


---

## 🎯 Future Enhancements

* 📋 View Employee List
* ✏️ Update Employee
* ❌ Delete Employee
* 🔐 Login Authentication
* 📊 Payroll calculations

---

## 👨‍💻 Author

**Apoorv Patel**
Java Web Developer (Beginner → Future FAANG 🚀)

---

## ⭐ If you like this project

Give it a **star ⭐ on GitHub** and support!

---
