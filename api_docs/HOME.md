### Table of Contents
* [Index](#markdown-header-index)


* **Notes:**

Only Admin user can access this resource.


## Index

It will response the all budgets data,expense data,income data and month names.

* **URL:** `/api`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes   
   
* **Success Response:**
  
    * **Code:** `200`
    * **Content:** 
    
```json 
     {
       "months": [
         "January",
         "February",
         "March",
         "April",
         "May",
         "June",
         "July",
         "August",
         "September",
         "October",
         "November",
         "December"
       ],
       "budgets": {
         "[2020, \"January\"]": "0.0",
         "[2020, \"March\"]": "870.0",
         "[2022, \"January\"]": "0.0"
       },
       "incomes": [
         0,
         0,
         0,
         "565.0",
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         0
       ],
       "expenses": [
         0,
         0,
         0,
         "225.0",
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         0,
         0
       ]
     }
```
  
