### Table of Contents
* [Index](#markdown-header-index)
* [Create](#markdown-header-create)
* [Show](#troubleshooting)
* [Destroy](#compatibility)
* [Update](#notes-and-miscellaneous)
* [Approve](#building-the-extension-bundles)
* [Reject](#next-steps)


## Index

Shows all the expenses the active user can access.

* **URL:** `/api/expenses`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes
  
+  **URL Params**
  
   * **Required:**
   
     * User Authentication token
     
        `token=[string]` (i.e. /api/expenses?token=value)

   * **Optional:**
 
      * The search will be held based on 3 attributes(*user name, category name or product name*) of expense resource.
 
         `search=[string]` (i.e. /api/expenses?token=value&search=value)
    
      * The date search will be held based on *expense date* of expense resource.
    
         `from=[date]`  `to=[date]` (i.e. /api/expenses?token=value&from=date&to=date)
        
         `date format = 'yy-mm-dd'`
   
   
* **Data Params:** None


* **Success Response:**
  
      * **Code:** 200
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
                 "url": "http://localhost:3000/api/expenses/17.json"
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
                 "url": "http://localhost:3000/api/expenses/15.json"
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
                 "url": "http://localhost:3000/api/expenses/10.json"
               }
             ]
           }
      ```
 
+ **Error Response:**

      * **Code:** `401 UNAUTHORIZED` 
      * **Content:** `{ error: "User have to sign in" }`

      OR

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** `{ error : "Invalid credentials" }`

* **Notes:**

      <p> The response will return all the expenses based on their status by 3 arrays( **pending_expenses, approved_expenses, rejected_expenses** ). </p>
  
  
## Create
  