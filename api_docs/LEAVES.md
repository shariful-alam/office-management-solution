### Table of Contents
* [Index](#markdown-header-index)
* [Create](#markdown-header-create)
* [Show](#markdown-header-show)
* [Destroy](#markdown-header-destroy)
* [Update](#markdown-header-update)
* [Approve](#markdown-header-undo)
* [Reject](#markdown-header-reject)


## Index

Shows all the leaves the active user can access.

* **URL:** `/api/leaves`

* **Method:**  `GET` 
  
* **Authentication required:**  `Yes`
  
*  **URL Params**
  
   * **Optional:**
 
      * The search will be held based on 2 attributes(*user name or leave type*) of leave resource.
 
         `search=[string]` (i.e. /api/leaves?token=value&search=value)
    
      * The date search will be held based on *start date* and *end date* of leave resource.
    
         `from=[date]`  `to=[date]` (i.e. /api/leaves?token=value&from=date&to=date)
        
         `date format = 'yy-mm-dd'`
   
   

* **Data Params:** `None`


* **Success Response:**
  
    * **Code:** `200`
  
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
   
 
* **Error Response:**

    * **Code:** `401 UNAUTHORIZED` 
    
    * **Content:** `{ error: "User have to sign in" }`
    
      OR
    
    * **Code:** `401 UNAUTHORIZED`
    
    * **Content:** `{ error : "Invalid credentials" }`

* **Notes:**

      The response will return all the leaves based on their status by 3 arrays( **pending_leaves, approved_leaves, rejected_leaves** ).
  
  
## Create
Apply for leave
* **URL** `/api/leaves`

* **Authentication required:**  `Yes`

* **Method:** `POST`
  
* **Data Params**

```json
{
	"start_date": "2020-02-20",
	"end_date": "2020-02-28",
	"reason": "asdddf",
	"leave_type": "Training"
}
```


* **Success Response:**

    * **Code:** 200
    * **Content:** 
```json
{
  "message": "Leave has been submitted for approval",
  "url": "/api/leaves/11.json"
}
```
   OR
```json
{
  "message": "Leave has been created",
  "url": "/api/leaves/12.json"
}
```
 
* **Error Response:**

    * **Code:** 401 UNAUTHORIZED <br />
    * **Content:** 
    ```json
      {
        "error": "Log in"
      }
    ```

  OR

    * **Code:** 422 UNPROCESSABLE ENTRY <br />
    * **Content:**
    ```json
      {
      	"error": "Email Invalid"
      }
    ```

* **Sample Call:**

  <_Just a sample call to your endpoint in a runnable format ($.ajax call or a curl request) - this makes life easier and more predictable._> 

* **Notes:**

  <_This is where all uncertainties, commentary, discussion etc. can go. I recommend timestamping and identifying oneself when leaving comments here._> 
  
  
## Show
Show the leave information if the logged in user have access

* **URL** `/api/leaves/:id`

* **Authentication required:**  `Yes`

* **Method:** `GET`

* **Success Response:**

  * **Code:** 200
  * **Content:** 
```json
{
  "id": 8,
  "user": {
    "id": 3,
    "name": "Shariful Alam"
  },
  "start_date": "20 February, 2020",
  "end_date": "28 February, 2020",
  "leave_type": "Training",
  "url": "/api/leaves/8.json",
  "status": "rejected"
}
```
 
* **Error Response:**

  * **Code:** 422 UNPROCESSABLE ENTITY
    **Content:**
    ```json
       {
         "message": "Record not found!!"
       }
    ```

* **Notes:**

      The response will return all the leaves based on their status by 3 arrays( **pending_leaves, approved_leaves, rejected_leaves** ).
