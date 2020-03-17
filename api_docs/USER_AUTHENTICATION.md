### Table of Contents
* [Create](#markdown-header-create)
* [Sign_out](#markdown-header-sign_out)



* **Notes:**

Only registered user can access. after successful sign in the response will return a access token.
By this token user can access all the resources based on authorization.
So every time user have to send this token in parameter except the time of creating the token or sign_in.

* Example : 
      * (/api/budgets?token=U4fXGfN2vNz1rvUzY6Nn)
      * (/api/expenses?token=U4fXGfN2vNz1rvUzY6Nn)
      * (/api/budgets/show_all_expenses.json?token=U4fXGfN2vNz1rvUzY6Nn&month=3&year=2020)


## Create

can create token for a user by which user can get access for other resources.

* **URL:** `/api/sessions`

* **Method:**  `POST` 

* **Required Fields**
    
    `email = [email]`
    
    `password = [password]`
    
    
* **Payload:**
     
```json
    {
    	"email": "bondhansarker100@gmail.com",
    	"password": "111111"
    }
```

* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json 
    {
      "token": "m-YCxFvzDMB8Ph4bgPGa"
    }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "message": "Email or password is invalid"
   }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "message": "User not found"
   }
```


## Sign_out

Can destroy the access token of a user.

* **URL:** `/api/sessions/sign_out`

* **Method:**  `PATCH` 
  
* **Authentication required:**  Yes

* **URL Params**
  
     * **Required:**
   
        * The token will identify the current_user.based on that it will destroy the user's access token.
   
            `token = [string]`   (i.e. /api/expenses?token=bzcU7GNsVLT6-mxp7MyT)
      
  
* **Success Response:**
 
       * **Code:** `200 OK`
       * **Content:** 
   
```json 
   {
     "message": "bzcU7GNsVLT6-mxp7MyT has been destroyed successfully"
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

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "message": "Email or password is invalid"
   }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "message": "User not found"
   }
```
   
  