function myFunction()
{
    var cancel_image = document.getElementById("cancel_image");
    var cancel_show = document.getElementById("cancel_show");
    if(cancel_image.checked == false)
    {
        cancel_show.style.display = "block";
        cancel_show.style.opacity = "1";
    }
    else
    {
        var txt;
        if (confirm("Are you sure ?"))
        {
            txt = 1;
        }
        else
        {
            txt = 0;
        }
        if(txt == 1)
        {
            cancel_show.style.display = "block";
            cancel_show.style.opacity = ".3";
        }
        else
        {
            cancel_image.checked = false;
        }
    }
}