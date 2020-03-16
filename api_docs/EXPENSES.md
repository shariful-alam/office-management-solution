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
  
*  **URL Params**
  
   **Required:**

      `token=[string]` (i.e. /api/expenses?token=value)

   **Optional:**
 
    * The search will be held based on 3 attributes(*user name, category name or product name*) of expense resource.
 
         `search=[string]` (i.e. /api/expenses?token=value&search=value)
    
    * The date search will be held based on *expense date* of expense resource.
    
         `from=[date]`  `to=[date]` (i.e. /api/expenses?token=value&from=date&to=date)
        
         `date format = 'yy-mm-dd'`
   
   

* **Data Params:** None


* **Success Response:**
  
  * **Code:** 200 <br />
    **Content:** 
    
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
 
* **Error Response:**

  * **Code:** `401 UNAUTHORIZED` <br/>
    **Content:** `{ error: "User have to sign in" }`

  OR

  * **Code:** `401 UNAUTHORIZED` <br/>
    **Content:** `{ error : "Invalid credentials" }`

* **Notes:**

  <pre>The response will return all the expenses based on their status by 3 arrays( **pending_expenses, approved_expenses, rejected_expenses** ).</pre>
  
  
## Create
  <_Additional information about your API call. Try to use verbs that match both request type (fetching vs modifying) and plurality (one vs multiple)._>

* **URL**

  <_The URL Structure (path only, no root url)_>

* **Method:**
  
  <_The request type_>

  `GET` | `POST` | `DELETE` | `PUT`
  
*  **URL Params**

   <_If URL params exist, specify them in accordance with name mentioned in URL section. Separate into optional and required. Document data constraints._> 

   **Required:**
 
   `id=[integer]`

   **Optional:**
 
   `photo_id=[alphanumeric]`

* **Data Params**

  <_If making a post request, what should the body payload look like? URL Params rules apply here too._>

* **Success Response:**
  
  <_What should the status code be on success and is there any returned data? This is useful when people need to to know what their callbacks should expect!_>

  * **Code:** 200 <br />
    **Content:** `{ id : 12 }`
 
* **Error Response:**

  <_Most endpoints will have many ways they can fail. From unauthorized access, to wrongful parameters etc. All of those should be liste d here. It might seem repetitive, but it helps prevent assumptions from being made where they should be._>

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "Log in" }`

  OR

  * **Code:** 422 UNPROCESSABLE ENTRY <br />
    **Content:** `{ error : "Email Invalid" }`

* **Sample Call:**

  <_Just a sample call to your endpoint in a runnable format ($.ajax call or a curl request) - this makes life easier and more predictable._> 

* **Notes:**

  <_This is where all uncertainties, commentary, discussion etc. can go. I recommend timestamping and identifying oneself when leaving comments here._> 