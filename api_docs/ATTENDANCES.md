### Table of Contents
* [Index](#markdown-header-index)
* [Create](#markdown-header-create)
* [Check_out](#markdown-header-check_out)

* **Notes:**

Only Admin user can access this resource.


## Index

Shows all the available and unavailable users of today.

* **URL:** `/api/attendances`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
  
    * **Code:** `200`
    * **Content:** 
    
```json 
     {
       "attendances": {
         "available": [
           {
             "user": "Api Admin",
             "check_in_time": "06:51 PM"
           }
         ],
         "unavailable": [
           {
             "user": "Bondhan Sarker",
             "check_in_time": "06:51 PM",
             "check_out_time": "06:51 PM",
             "total_time_spent": "less than a minute"
           }
         ]
       }
     }
```
 
* **Notes:**

It will response with two arrays.
  

## Create

Can create new attendance.

* **URL:** `/api/attendances`

* **Method:**  `POST` 
  
* **Authentication required:**  Yes
    
* **Success Response:**
 
       * **Code:** `201 CREATED`
       * **Content:** 
   
```json 
    {
      "message": "You have checked In Successfully!!"
    }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "message": "You have already checked In Today!!"
   }
```
* or
      
      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json 
   {
     "message": "You can not access this from outside !!"
   }
```


## Check_out

Can checkout for a attendance.

* **URL:** `/api/attendances/check_out`

* **Method:**  `PATCH` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
   
```json 
   {
     "message": "You have checked Out Successfully!!"
   }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "message": "You are not checked in"
   }
   
```
* or
      
      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json 
   {
     "message": "You can not access this from outside !!"
   }
```
   
  