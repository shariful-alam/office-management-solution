### Table of Contents
* [Index](#markdown-header-index)
* [Show](#markdown-header-show)
* [Create](#markdown-header-create)
* [Update](#markdown-header-update)
* [Destroy](#markdown-header-destroy)
* [Show_all](#markdown-header-show_all)


* **Notes:**

Only Admin user can access this resource.


## Index

Shows all the allocated leaves of all users.

* **URL:** `/api/allocated_leaves`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes
  
* **URL Params**
  
     * **Optional:**
   
          * The search will be held based on YEAR.
           If the parameter is not given then it will response data for the present year.

            `search = [year]`   (i.e. /api/allocated_leaves?search=2020)
      
     
   
* **Success Response:**
  
    * **Code:** `200`
    * **Content:** 
    
```json 
     {
       "allocated_leafe": [
         {
           "id": 9,
           "user": {
             "id": 8,
             "name": "Bondhan Sarker"
           },
           "total_leaves": 45,
           "used_leaves": 0,
           "remaining_leaves": 45,
           "url": "/api/allocated_leaves/9.json"
         },
         {
           "id": 8,
           "user": {
             "id": 6,
             "name": "Api Admin"
           },
           "total_leaves": 34,
           "used_leaves": 15,
           "remaining_leaves": 19,
           "url": "/api/allocated_leaves/8.json"
         }
       ]
     }
``` 
  
## Show

Show the user's allocated leave details.

* **URL:** `/api/allocated_leaves/:id`

* **Method:** `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
  
      * **Code:** `200`
      * **Content:** 
    
```json 
     {
       "allocated_leaves": {
         "id": 8,
         "user": {
           "id": 6,
           "name": "Api Admin"
         },
         "total_leaves": 34,
         "used_leaves": 15,
         "remaining_leaves": 19,
         "url": "http://localhost:3000/api/allocated_leaves/8.json",
         "leafe_for_year": "2020",
         "personal_leave": 0,
         "training_leave": 1,
         "vacation_leave": 0,
         "medical_leave": 0
       }
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


## Create

Can allocate leave for a user for a year.

* **URL:** `/api/allocated_leaves`

* **Method:**  `POST` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
    
    `user_id = [integer]`
    
    `year = [integer]`
    
    `total_leave = [integer]`
    
* **Payload:**
     
```json
    {
    	"allocated_leafe": {
    		"user_id": 8,
    		"year": 2020,
    		"total_leave": 40
    	}
    }
```
* **Success Response:**
 
       * **Code:** `201 CREATED`
       * **Content:** 
   
```json 
    {
      "message": "Leave has been allocated successfully!!",
      "url": "/api/allocated_leaves/6.json"
    }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "errors": {
       "year": [
         "has already been taken"
       ]
     }
   }
```


## Update

Can update existing allocated leafe.

* **URL:** `/api/allocated_leaves/:id`

* **Method:**  `PATCH` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
        
     `year = [integer]`
        
     `total_leave = [integer]`
    
* **Payload:**
     
```json
    {
    	"allocated_leafe": {
    		"year": 2026,
    		"total_leave": 470
    	}
    }
```
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
   
```json 
   {
     "message": "Your information has been updated successfully",
     "url": "/api/allocated_leaves/10.json"
   }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "errors": {
       "total_leave": [
         "is not a number"
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


Can destroy existing allocated leafe for a user.


* **URL:** `/api/allocated_leaves/:id`

* **Method:**  `DELETE` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
   
```json 
   {
     "message": "Information has been removed!!"
   }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error" : "Information could not be deleted!!" }
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


## Show_all

Shows all the leaves of a user who has allocated leave.

* **URL:** `/api/allocated_leaves/8/show_all`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes 
   
* **Success Response:**
  
    * **Code:** `200`
    * **Content:** 
    
```json 
     {
       "show_all": {
         "user": "Api Admin",
         "pending_leaves": [],
         "approved_leaves": [
           {
             "id": 2,
             "user": {
               "id": 6,
               "name": "Api Admin"
             },
             "start_date": "09 March, 2020",
             "end_date": "27 March, 2020",
             "leave_type": "Training",
             "url": "/api/leaves/2.json"
           }
         ],
         "rejected_leaves": [
           {
             "id": 1,
             "user": {
               "id": 6,
               "name": "Api Admin"
             },
             "start_date": "05 March, 2020",
             "end_date": "24 March, 2020",
             "leave_type": "Personal Leave",
             "url": "/api/leaves/1.json"
           }
         ]
       }
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
