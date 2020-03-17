### Table of Contents
* [Index](#markdown-header-index)
* [Create](#markdown-header-create)
* [Show](#markdown-header-show)
* [Destroy](#markdown-header-destroy)
* [Update](#markdown-header-update)
* [Approve](#markdown-header-undo)
* [Undo](#markdown-header-undo)
* [Reject](#markdown-header-reject)


## Index

Shows all the leaves the active user can access.

* **URL:** `/api/leaves`

* **Method:**  `GET` 
  
* **Authentication required:**  `Yes`
  
* **URL Params**
  
     * **Optional:**
   
        * The search will be held based on 2 attributes(*user name or leave type*) of leave resource.
   
           `search=[string]` (i.e. /api/leaves?token=value&search=value)
      
        * The date search will be held based on *start date* and *end date* of leave resource.
      
           `from=[date]`  `to=[date]` (i.e. /api/leaves?token=value&from=date&to=date)
          
           `date format = 'yy-mm-dd'`
   

* **Success Response:**
  
    * **Code:** `200 OK`
  
    * **Content:** 
  
```json
    {
      "pending_leaves": [
        {
          "id": 9,
          "user": {
            "id": 1,
            "name": "Bazlur Rashid"
          },
          "start_date": "04 March, 2020",
          "end_date": "10 March, 2020",
          "leave_type": "Personal Leave",
          "url": "/api/leaves/9.json"
        }
      ],
      "approved_leaves": [
        {
          "id": 10,
          "user": {
            "id": 1,
            "name": "Bazlur Rashid"
          },
          "start_date": "17 March, 2020",
          "end_date": "23 March, 2020",
          "leave_type": "Vacation",
          "url": "/api/leaves/10.json"
        }
      ],
      "rejected_leaves": [
        {
          "id": 8,
          "user": {
            "id": 3,
            "name": "Shariful Alam"
          },
          "start_date": "20 February, 2020",
          "end_date": "28 February, 2020",
          "leave_type": "Training",
          "url": "/api/leaves/8.json"
        }
      ]
    }
```

* **Notes:**

      The response will return all the leaves based on their status by 3 arrays( **pending_leaves, approved_leaves, rejected_leaves** ).
  
  
## Create

Apply for leave

* **URL** `/api/leaves`

* **Method:** `POST`

* **Authentication required:**  `Yes`

* **Required Fields**
    
    `start_date = [date]`
    
    `end_date = [date]`
    
    `reason = [string]`
    
    `leave_type = [string]`
  
* **Payload**

```json
    {
    	"leafe": {
    		"start_date": "2020-02-20",
    		"end_date": "2020-02-28",
    		"reason": "asdddf",
    		"leave_type": "Training"
    	}
    }
```


* **Success Response:**

       * **Code:** `201 CREATED`
       * **Content:** 
```json
{
  "message": "Leave has been submitted for approval",
  "url": "/api/leaves/:id"
}
```
   OR
```json
{
  "message": "Leave has been created",
  "url": "/api/leaves/:id"
}
```
 
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    {
    	"errors": {
    		"start_date": [
    			"can't be blank",
    			"Please select a valid date range"
    		],
    		"end_date": [
    			"can't be blank",
    			"Please select a valid date range"
    		],
    		"reason": [
            "can't be blank"
          ]
    	}
    }
```
  
## Show

Show the leave information if the logged in user have access.

* **URL** `/api/leaves/:id`

* **Method:** `GET`

* **Authentication required:**  `Yes`

* **Success Response:**

      * **Code:** `200 OK`
      * **Content:** 
      
```json
    {
      "id": 13,
      "user": {
        "id": 1,
        "name": "Bazlur Rashid"
      },
      "start_date": "20 February, 2020",
      "end_date": "28 February, 2020",
      "leave_type": "Training",
      "url": "/api/leaves/13",
      "status": "approved",
      "approve_time": "17 March, 2020 at 03:36 PM"
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

Can update existing leave if the leave is in pending status.

* **URL:** `/api/leaves/:id`

* **Method:**  `PATCH` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
    
    `start_date = [date]`
        
    `end_date = [date]`
    
    `reason = [string]`
    
    `leave_type = [string]`
    
* **Payload:**
     
```json
    {
    	"leafe": {
    		"start_date": "2020-02-20",
    		"end_date": "2020-02-28",
    		"reason": "Going home",
    		"leave_type": "Training"
    	}
    }
```
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "Leave has been updated",
      "url": "/api/leaves/:id"
    }
```

* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    {
    	"errors": {
    		"start_date": [
    			"can't be blank",
    			"Please select a valid date range"
    		],
    		"end_date": [
    			"can't be blank",
    			"Please select a valid date range"
    		],
    		"reason": [
    			"can't be blank"
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


Can destroy existing leave.


* **URL:** `/api/leaves/:id`

* **Method:**  `DELETE` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "Leave has been destroyed"
    }
```

* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error" : "Leave could not be deleted!!" }
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

## Approve


Can approve existing leave if the leave is in pending status.


* **URL:** `/api/leaves/:id/approve`

* **Method:**  `PUT` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "The leave has been approved successfully"
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

## Undo


Can undo an approved leave.


* **URL:** `/api/leaves/:id/approve`

* **Method:**  `PUT` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "Leave information has been changed successfully"
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

## Reject


Can reject an pending leave.


* **URL:** `/api/leaves/:id/reject`

* **Method:**  `PUT` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
```json
    {
      "message": "Leave has been rejected"
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





