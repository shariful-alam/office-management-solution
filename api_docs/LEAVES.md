### Table of Contents
* [Index](#markdown-header-index)
* [Create](#markdown-header-create)
* [Show](#troubleshooting)
* [Destroy](#compatibility)
* [Update](#notes-and-miscellaneous)
* [Approve](#building-the-extension-bundles)
* [Reject](#next-steps)


## Index

Shows all the leaves the active user can access.

* **URL:** `/api/leaves`

* **Method:**  `GET` 
  
* **Authentication required:**  `Yes`
  
*  **URL Params**
  
   * **Required:**
   
        `token=[string]` (i.e. /api/leaves?token=value)

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
          "url": "http://localhost:3000/api/leaves/9.json"
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
          "url": "http://localhost:3000/api/leaves/10.json"
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
          "url": "http://localhost:3000/api/leaves/8.json"
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

  <p>The response will return all the expenses based on their status by 3 arrays( **pending_expenses, approved_expenses, rejected_expenses** ).</p>
  
  
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