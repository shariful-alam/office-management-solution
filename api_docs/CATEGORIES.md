### Table of Contents
* [Index](#markdown-header-index)
* [Create](#markdown-header-create)
* [Show](#markdown-header-show)
* [Destroy](#markdown-header-destroy)
* [Update](#markdown-header-update)


## Index

Shows all categories.

* **URL:** `/api/categories`

* **Method:**  `GET` 
  
* **Authentication required:**  `Yes`
       

* **Success Response:**
  
    * **Code:** `200 OK`
  
    * **Content:** 
  
```json
    [
      {
        "id": 1,
        "name": "Food",
        "url": "/api/categories/1.json"
      },
      {
        "id": 3,
        "name": "Logistics",
        "url": "/api/categories/3.json"
      }
    ]
```

* **Notes:**

      The response will return an array of categories.
  
  
## Create

Create new category

* **URL** `/api/categories`

* **Method:** `POST`

* **Authentication required:**  `Yes`

* **Required Fields**
    
    `name = [string]`
  
* **Payload**

```json
    {
    	"category": {
    		"name": "Logistics"
    	}
    }
```


* **Success Response:**

       * **Code:** `201 CREATED`
       * **Content:** 
```json
    {
      "message": "Category for Budget has been created successfully!!",
      "url": "/api/categories/:id"
    }
```
 
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    {
    	"errors": {
    		"name": [
    			"can't be blank"
    		]
    	}
    }
```
  
## Show

Show the category information.

* **URL** `/api/categories/:id`

* **Method:** `GET`

* **Authentication required:**  `Yes`

* **Success Response:**

      * **Code:** `200 OK`
      * **Content:** 
      
```json
    {
      "id": 3,
      "name": "Logistics",
      "url": "/api/categories/3.json"
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

Can update existing category.

* **URL:** `/api/categories/:id`

* **Method:**  `PATCH` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
    
    `name = [string]`
    
* **Payload:**
     
```json
    {
    	"category": {
    		"name": "Food"
    	}
    }
```
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "Category for Budget has been updated successfully!!",
      "url": "/api/categories/:id"
    }
```

* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    {
    	"errors": {
    		"name": [
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


Can destroy existing category.


* **URL:** `/api/categories/:id`

* **Method:**  `DELETE` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json
    {
      "message": "Category for Budget has been removed successfully!!"
    }
```

* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error" : "Category could not be deleted!!" }
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




