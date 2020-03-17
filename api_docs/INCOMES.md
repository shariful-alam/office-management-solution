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

Shows total income per user on monthly basis.

* **URL:** `/api/incomes`

* **Method:**  `GET` 
  
* **Authentication required:**  `Yes`
  
* **URL Params**
  
     * **Optional:**
   
        * The search will be held based on 1 attribute only(*year*) of income resource.
   
            `search=[integer]` (i.e. /api/incomes?token=value&search=value)
      

* **Success Response:**
  
    * **Code:** `200 OK`
  
    * **Content:** 
  
```json
    {
      "incomes": [
        {
          "Shariful Alam": {
            "January": "0.0",
            "February": "100.0",
            "March": "1000.0",
            "April": "0.0",
            "May": "0.0",
            "June": "0.0",
            "July": "0.0",
            "August": "0.0",
            "September": "0.0",
            "October": "0.0",
            "November": "0.0",
            "December": "0.0"
          }
        },
        {
          "Bazlur Rashid": {
            "January": "0.0",
            "February": "0.0",
            "March": "1100.0",
            "April": "0.0",
            "May": "0.0",
            "June": "0.0",
            "July": "0.0",
            "August": "0.0",
            "September": "0.0",
            "October": "0.0",
            "November": "0.0",
            "December": "0.0"
          }
        }
      ],
      "bonuses": [
        {
          "Shariful Alam": {
            "January": 0,
            "February": 0,
            "March": 0,
            "April": 0,
            "May": 0,
            "June": 0,
            "July": 0,
            "August": 0,
            "September": 0,
            "October": 0,
            "November": 0,
            "December": 0
          }
        },
        {
          "Bazlur Rashid": {
            "January": 0,
            "February": 0,
            "March": 0,
            "April": 0,
            "May": 0,
            "June": 0,
            "July": 0,
            "August": 0,
            "September": 0,
            "October": 0,
            "November": 0,
            "December": 0
          }
        }
      ]
    }
```

* **Notes:**

      The response will return total income per month of each individual user by 2 arrays( **Incomes, Bonuses** ).
  
  
## Create

Create new income

* **URL** `/api/incomes`

* **Method:** `POST`

* **Authentication required:**  `Yes`

* **Required Fields**
    
      `amount = [decimal]`
      
      `income_date = [date]`
      
      `source = [string]`
  
* **Payload**

```json
    {
    	"income": {
    		"amount": 1000,
    		"income_date": "2020-03-11",
    		"source": "Service"
    	}
    }
```


* **Success Response:**

       * **Code:** `201 CREATED`
       * **Content:** 
```json
    {
      "message": "Income has been submitted for approval",
      "url": "/api/incomes/:id"
    }
```
   OR
```json
    {
      "message": "Income has been created successfully",
      "url": "/api/incomes/:id"
    }
```
 
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    {
    	"errors": {
    		"amount": [
    			"can't be blank",
    			"is not a number"
    		],
    		"income_date": [
    			"can't be blank"
    		]
    	}
    }
```
  
## Show

Show the income information if the logged in user have access.

* **URL** `/api/incomes/:id`

* **Method:** `GET`

* **Authentication required:**  `Yes`

* **Success Response:**

      * **Code:** `200 OK`
      * **Content:** 
      
```json
    {
      "id": 20,
      "user": {
        "id": 3,
        "name": "Shariful Alam"
      },
      "amount": "1000.0",
      "source": "Service",
      "status": "pending",
      "url": "/api/incomes/20.json"
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

* **URL:** `/api/incomes/:id`

* **Method:**  `PATCH` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
    
      `amount = [decimal]`
          
      `income_date = [date]`
      
      `source = [string]`
    
* **Payload:**
     
```json
    {
    	"income": {
    		"amount": 1000,
    		"income_date": "2020-03-11",
    		"source": "Service"
    	}
    }
```
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "Income information has been updated",
      "url": "/api/incomes/:id.json"
    }
```

* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    {
    	"errors": {
    		"amount": [
    			"can't be blank",
    			"is not a number"
    		],
    		"income_date": [
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


Can destroy existing income.


* **URL:** `/api/incomes/:id`

* **Method:**  `DELETE` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "Income information has been destroyed"
    }
```

* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error" : "Income could not be deleted!!" }
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


Can approve existing income if the income is in pending status.


* **URL:** `/api/incomes/:id/approve`

* **Method:**  `PUT` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "Income has been approved"
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


Can undo an approved income.


* **URL:** `/api/incomes/:id/approve`

* **Method:**  `PUT` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "The income status has been changed successfully"
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


Can reject an pending income.


* **URL:** `/api/incomes/:id/reject`

* **Method:**  `PUT` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
```json
    {
      "message": "Income has been rejected"
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





