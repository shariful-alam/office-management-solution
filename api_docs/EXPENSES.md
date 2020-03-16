### Table of Contents
* [Index](#markdown-header-index)
* [Show](#markdown-header-show)
* [Create](#markdown-header-create)
* [Destroy](#compatibility)
* [Update](#notes-and-miscellaneous)
* [Approve](#building-the-extension-bundles)
* [Reject](#next-steps)


## Index

Shows all the expenses the active user can access.

* **URL:** `/api/expenses`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes
  
* **URL Params**
  
     * **Optional:**
   
        * The search will be held based on 3 attributes(*user name, category name or product name*) of expense resource.
   
            `search=[string]`   (i.e. /api/expenses?token=value&search=value)
      
        * The date search will be held based on *expense date* of expense resource.
      
             `from=[date]`  `to=[date]`   (i.e. /api/expenses?token=value&from=start_date&to=end_date)
            
             `date format = 'yy-mm-dd'`
   
   
* **Success Response:**
  
    * **Code:** `200`
    * **Content:** 
    
```json 
     {
       "pending_expenses": [
         {
           "id": 17,
           "user": {
             "id": 6,
             "name": "Api Admin"
           },
           "product_name": "Pencil",
           "category": "d",
           "cost": "45.0",
           "expense_date": "2020-03-01",
           "url": "/api/expenses/17.json"
         }
       ],
       "approved_expenses": [
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
           "url": "/api/expenses/15.json"
         }
     ],
       "rejected_expenses": [
         {
           "id": 10,
           "user": {
             "id": 8,
             "name": "Bondhan Sarker"
           },
           "product_name": "Pen",
           "category": "d",
           "cost": "45.0",
           "expense_date": "2020-03-01",
           "url": "/api/expenses/10.json"
         }
       ]
     }
```
 
* **Notes:**

      The response will return all the expenses based on their status by 3 arrays( **pending_expenses, approved_expenses, rejected_expenses** ).
  
  
## Show

Show the expense if the login user have access.

* **URL:** `/api/expenses/:id`

* **Method:** `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
  
      * **Code:** `200`
      * **Content:** 
    
```json 
     {
       "id": 17,
       "user": {
         "id": 6,
         "name": "Api Admin"
       },
       "product_name": "Pencil",
       "category": "d",
       "cost": "45.0",
       "expense_date": "2020-03-01",
       "url": "/api/expenses/17.json",
       "status": "pending"
     }
```
 
* **Error Response:**

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```
*or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

## Create

Show the expense if the login user have access.

* **URL:** `/api/expenses/:id`

* **Method:**  `POST` 
  
* **Authentication required:**  Yes
  
* **Payload:**
     
```json
    {
      "expense": {
        "product_name": "Pencil",
        "cost": 45.00,
        "expense_date": "2020-03-01",
        "category_id": 1
      }
     }
```
* **Success Response:**
 
       * **Code:** `201 CREATED`
       * **Content:** 
   
```json 
    {
      "id": 17,
      "user": {
        "id": 6,
        "name": "Api Admin"
      },
      "product_name": "Pencil",
      "category": "d",
      "cost": "45.0",
      "expense_date": "2020-03-01",
      "url": "/api/expenses/17.json",
      "status": "pending"
    }
```
* **Error Response:**




  