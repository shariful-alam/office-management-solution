### Table of Contents
* [Index](#markdown-header-index)
* [Show](#markdown-header-show)
* [Show_all](#markdown-header-show_all)
* [Show_all_expenses](#markdown-header-show_all_expenses)
* [Create](#markdown-header-create)
* [Update](#markdown-header-update)
* [Destroy](#markdown-header-destroy)



* **Notes:**

Only Admin user can access this resource.


## Index

Shows all the budgets based on months of a selected year. 

* **URL:** `/api/budgets`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes
  
* **URL Params**
  
     * **Optional:**
   
        * The search will be held based on YEAR of budget resource. If the parameter is not given then it will show data for the present year.
   
            `search = [year]`   (i.e. /api/budgets?search=2020)
      
   
   
* **Success Response:**
  
    * **Code:** `200`
    * **Content:** 
    
```json 
     {
       "budget_amount": [
         {
           "January": {
             "month": 1,
             "year": 2022,
             "url_for_month_budget": "/api/budgets/show_all.json?month=1&year=2022",
             "amount": "56.0",
             "expense": 0,
             "remaining": 56,
             "url_for_month_expenses": "/api/budgets/show_all_expenses.json?month=1&year=2022"
           }
         }
       ]
     }
```
 
* **Notes:**

The response will return all the budget based on searched year.and It will show searched year's monthly budgets intotal.

  
## Show

Show the budget information.

* **URL:** `/api/budgets/:id`

* **Method:** `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
  
      * **Code:** `200`
      * **Content:** 
    
```json 
     {
       "id": 1,
       "category": "d",
       "year": 2020,
       "month": 3,
       "amount": "5555.0",
       "expense": "870.0",
       "remaining": "4685.0",
       "user": {
         "id": 6,
         "name": "Api Admin"
       },
       "url": "/api/budgets/1.json"
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

## Show_all

Show all catagorized budget information of the paramatererized month and year.

* **URL:** `/api/budgets/show_all.json?month=3&year=2020`

* **Method:** `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
  
      * **Code:** `200`
      * **Content:** 
    
```json 
     {
       "year": 2020,
       "month": "March",
       "total_budget": "9555.0",
       "total_expense": "870.0",
       "total_remaining": "8685.0",
       "show_all_budgets": [
         {
           "id": 1,
           "category": "d",
           "year": 2020,
           "month": 3,
           "amount": "5555.0",
           "expense": "870.0",
           "remaining": "4685.0",
           "user": {
             "id": 6,
             "name": "Api Admin"
           },
           "url": "/api/budgets/1.json"
         },
         {
           "id": 2,
           "category": "ttrt",
           "year": 2020,
           "month": 3,
           "amount": "4000.0",
           "expense": "0.0",
           "remaining": "4000.0",
           "user": {
             "id": 6,
             "name": "Api Admin"
           },
           "url": "/api/budgets/2.json"
         }
       ]
     }
```
 
* **Error Response:**


      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "message": "Budget for March, 2027 is not created yet" }
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

## Show_all_expenses

Show all expenses of the paramatererized month and year.

* **URL:** `/api/budgets/show_all_expenses.json?month=3&year=2020`

* **Method:** `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
  
      * **Code:** `200`
      * **Content:** 
    
```json 
     {
       "year": 2020,
       "month": "March",
       "total_budget": "9555.0",
       "total_expense": "870.0",
       "total_remaining": "8685.0",
       "show_all_expenses": [
         {
           "id": 15,
           "user": {
             "id": 6,
             "name": "Api Admin"
           },
           "product_name": "Pen",
           "category": "d",
           "cost": "45.0",
           "expense_date": "2020-03-01",
           "url": "http://localhost:3000/api/expenses/15.json"
         },
         {
           "id": 16,
           "user": {
             "id": 6,
             "name": "Api Admin"
           },
           "product_name": "Pencil",
           "category": "d",
           "cost": "45.0",
           "expense_date": "2020-03-01",
           "url": "http://localhost:3000/api/expenses/16.json"
         }
       ]
     }
```
 
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "message": "Budget for March, 2027 is not created yet" }
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

## Create

Can create new budget.

* **URL:** `/api/budgets.json`

* **Method:**  `POST` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
    
    `year = [integer]`
    
    `month = [integer]`
    
    `amount = [decimal]`
    
    `category_id = [integer]`
    
* **Payload:**
     
```json
   {
   	"budget": {
   		"year": 2020,
   		"month": 1,
   		"amount": 10000,
   		"category_id": 2
   	}
   }
```
* **Success Response:**
 
       * **Code:** `201 CREATED`
       * **Content:** 
   
```json 
    {
      "message": "Budget has been created successfully!!",
      "url": "/api/budgets/7.json"
    }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "errors": {
       "month": [
         "has already been taken"
       ]
     }
   }
```

* **Notes**

There can be many budgets on different categories for a month. but a month cannot have multiple budgets on same category. 


## Update

Can update existing budget. and can add more amount by using `add` attribute value.

* **URL:** `/api/budgets/:id`

* **Method:**  `PATCH` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
    
    `year = [integer]`
    
    `month = [integer]`
    
    `amount = [decimal]`
    
    `category_id = [integer]`
    
    `add = [integer]`
    
* **Payload:**
     
```json
    {
    	"budget": {
    		"year": 2020,
    		"month": 1,
    		"category_id": 2,
    		"add": "2000.0"
    	}
    }
```
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
   
```json 
    {
      "message": "Budget has been updated successfully!!",
      "url": "/api/budgets/3.json"
    }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "errors": {
       "category": [
         "must exist"
       ]
     }
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

Can destroy an existing budget.


* **URL:** `/api/budgets/:id`

* **Method:**  `DELETE` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
   
```json 
    {
      "message": "Budget has been removed successfully!!",
    }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error" : "Budget could not be deleted!!" }
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

  