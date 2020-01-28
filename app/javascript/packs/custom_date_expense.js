   function myFunction()
    {
        var previous = document.getElementById("previous");
        var select_previous = document.getElementById("select_previous");

        if(previous.checked == false)
        {
            select_previous.style.display = "none";
        }
        else
        {
            select_previous.style.display = "block";
        }

    }