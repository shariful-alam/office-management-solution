### Table of Contents
* [Index](#markdown-header-index)
* [Create](#markdown-header-create)
* [Show](#markdown-header-show)
* [Destroy](#markdown-header-destroy)
* [Update](#markdown-header-update)
* [Show all pending](#markdown-header-show-all-pending)
* [Show all expenses](#markdown-header-show-all-expenses)
* [Show all incomes](#markdown-header-show-all-incomes)


## Index

Shows all the users.

* **URL:** `/api/manage/users`

* **Method:**  `GET` 
  
* **Authentication required:**  `Yes`
  
* **URL Params**
  
     * **Optional:**
   
        * The search will be held based on 1 attribute only(*user name*) of user resource.
   
            `search=[string]` (i.e. /api/manage/users?token=value&search=value)
   

* **Success Response:**
  
    * **Code:** `200 OK`
  
    * **Content:** 
  
```json
    [
      {
        "id": 1,
        "name": "Bazlur Rashid",
        "email": "admin@rightcodes.org",
        "phone": "01521",
        "role": "Admin",
        "designation": "Office Admin",
        "target_amount": "10000.0",
        "bonus_percentage": "10.0",
        "url": "/api/manage/users/1.json"
      },
      {
        "id": 3,
        "name": "Shariful Alam",
        "email": "shariful.alam85@gmail.com",
        "phone": "01710139950",
        "role": "Employee",
        "designation": "Junior Software Engineer",
        "target_amount": "10000.0",
        "bonus_percentage": "5.0",
        "url": "/api/manage/users/3.json"
      }
    ]
```

* **Notes:**

      The response will return an array of users.
  
  
## Create

Create user

* **URL** `/api/manage/users`

* **Method:** `POST`

* **Authentication required:**  `Yes`

* **Required Fields**
    
      `email = [string]`
      
      `name = [string]`
      
      `phone = [string]`
      
      `target_amount = [decimal]`
      
      `bonus_percentage = [decimal]`
      
      `password = [string]`
  
* **Payload**

```json
    {
    	"user": {
    		"name": "Hemal",
    		"email": "shariful.alam@rightcodes.org",
    		"role": "Admin",
    		"password": "111111",
    		"password_confirmation": "111111",
    		"phone": "01521",
    		"target_amount": 10000,
    		"bonus_percentage": 10
    	}
    }
```


* **Success Response:**

       * **Code:** `201 CREATED`
       * **Content:** 
```json
    {
      "message": "User has been created successfully",
      "url": "/api/manage/users/:id"
    }
```
 
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    {
      "email": [
        "can't be blank",
        "has already been taken"
      ],
      "password": [
        "can't be blank"
      ],
      "password_confirmation": [
        "doesn't match Password"
      ],
      "name": [
        "can't be blank"
      ]
    }
```
  
## Show

Show the user information.

* **URL** `/api/manage/users/:id`

* **Method:** `GET`

* **Authentication required:**  `Yes`

* **Success Response:**

      * **Code:** `200 OK`
      * **Content:** 
      
```json
    {
      "id": 3,
      "name": "Shariful Alam",
      "email": "shariful.alam85@gmail.com",
      "phone": "01710139950",
      "role": "Employee",
      "designation": "Junior Software Engineer",
      "target_amount": "10000.0",
      "bonus_percentage": "5.0",
      "url": "/api/manage/users/3.json"
    }
```
 
* **Error Response:**

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```


## Update

Can update existing user information.

* **URL:** `/api/manage/users/:id`

* **Method:**  `PATCH` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
    
      `email = [string]`
      
      `name = [string]`
      
      `phone = [string]`
      
      `target_amount = [decimal]`
      
      `bonus_percentage = [decimal]`
      
      `password = [string]`
    
* **Payload:**
     
```json
    {
    	"user": {
    		"name": "Hemal",
    		"email": "shariful.alam@rightcodes.org",
    		"phone": "01521",
    		"target_amount": 30000,
    		"designation": "Junior Software Engineer"
    	}
    }
```
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "User data has been updated successfully",
      "url": "/api/manage/users/:id"
    }
```

* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    {
    	"email": [
    		"can't be blank",
    		"has already been taken"
    	],
    	"password": [
    		"can't be blank"
    	],
    	"password_confirmation": [
    		"doesn't match Password"
    	],
    	"name": [
    		"can't be blank"
    	]
    }
```
   
* or   

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

## DESTROY


Can destroy existing user.


* **URL:** `/api/manage/users/:id`

* **Method:**  `DELETE` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "User has been removed successfully!!"
    }
```

* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error" : "User could not be deleted!!" }
```
   
* or   

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

## Show all pending


Shows all the pending resources.


* **URL:** `/api/manage/users/show_all_pending`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "pending_expenses": [
        {
          "id": 7,
          "user": {
            "id": 8,
            "name": "Bazlur Rashid"
          },
          "product_name": "edrf",
          "category": "Food",
          "cost": "543.0",
          "expense_date": "2020-01-06",
          "url": "http://localhost:3000/api/expenses/7.json"
        }
      ],
      "pending_leaves": [
        {
          "id": 15,
          "user": {
            "id": 8,
            "name": "Bazlur Rashid"
          },
          "start_date": "16 March, 2020",
          "end_date": "18 March, 2020",
          "leave_type": "Personal Leave",
          "url": "http://localhost:3000/api/leaves/15.json"
        }
      ],
      "pending_incomes": [
        {
          "id": 22,
          "user": {
            "id": 8,
            "name": "Bazlur Rashid"
          },
          "amount": "1000.0",
          "source": "Employee",
          "status": "pending",
          "url": "http://localhost:3000/api/incomes/22.json"
        }
      ]
    }
```

* **Error Response:**

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* **Notes:**

      The response will return all the pending resources by 3 arrays( **pending_expneses, pending_leaves, pending_incomes** ).
  
  

## Show all expenses


Shows all expenses of an individual user.


* **URL:** `/api/manage/users/:id/show_all_expenses`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "pending_expenses": [
        {
          "id": 7,
          "user": {
            "id": 8,
            "name": "Bazlur Rashid"
          },
          "product_name": "edrf",
          "category": "Food",
          "cost": "543.0",
          "expense_date": "2020-01-06",
          "url": "http://localhost:3000/api/expenses/7.json"
        }
      ],
      "approved_expenses": [
        {
          "id": 6,
          "user": {
            "id": 8,
            "name": "Bazlur Rashid"
          },
          "product_name": "eee",
          "category": "Food",
          "cost": "125.0",
          "expense_date": "2020-03-16",
          "url": "http://localhost:3000/api/expenses/6.json"
        }
      ],
      "rejected_expenses": [
        {
          "id": 5,
          "user": {
            "id": 8,
            "name": "Bazlur Rashid"
          },
          "product_name": "asdf",
          "category": "Food",
          "cost": "333.0",
          "expense_date": "2020-03-16",
          "url": "http://localhost:3000/api/expenses/5.json"
        }
      ]
    }
```
   
* **Error Response:**

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

* **Notes:**

      The response will return all the expenses of an individual user based on their status by 3 arrays( **pending_expenses, approved_expenses, rejected_expenses** ).
  
  

## Show all incomes


Can reject an pending leave.


* **URL:** `/api/manage/users/:id/show_all_incomes`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
```json
    {
      "pending_incomes": [
        {
          "id": 22,
          "user": {
            "id": 8,
            "name": "Bazlur Rashid"
          },
          "amount": "1000.0",
          "source": "Employee",
          "status": "pending",
          "url": "http://localhost:3000/api/incomes/22.json"
        }
      ],
      "approved_incomes": [
        {
          "id": 24,
          "user": {
            "id": 8,
            "name": "Bazlur Rashid"
          },
          "amount": "25000.0",
          "source": "Service",
          "status": "approved",
          "url": "http://localhost:3000/api/incomes/24.json"
        }
      ],
      "rejected_incomes": [
        {
          "id": 23,
          "user": {
            "id": 8,
            "name": "Bazlur Rashid"
          },
          "amount": "500.0",
          "source": "Employee",
          "status": "rejected",
          "url": "http://localhost:3000/api/incomes/23.json"
        }
      ]
    }
```

* **Error Response:**

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

* **Notes:**

      The response will return all the incomes of an individual user based on their status by 3 arrays( **pending_incomes, approved_incomes, rejected_incomes** ).
  
  





