/*This is a custom script file containing notification, alert etc.*/
/* Author- Smitanjali Hansdah */
function viewNotification(type)
{
	if(type==1)
	{
	    Snackbar.show({
	        text: 'Select any District/ Division to view layer.',
	        pos: 'top-center'
    	});
	}
	else if(type==2)
	{
	    Snackbar.show({
	        text: 'Select any District to view layer.',
	        pos: 'top-center'
    	});
	}
	else if(type==3)
	{
	    Snackbar.show({
	        text: 'Select any Division to view layer.',
	        pos: 'top-center'
    	});
	}
	else if(type==4)
	{
	    Snackbar.show({
	        text: 'Select Forest Land Type.',
	        pos: 'top-center'
    	});
	}
	else if(type==5)
	{
	    Snackbar.show({
	        text: 'Data saved successfully',
	        pos: 'top-center'
    	});
	}
	else if(type==6)
	{
	    Snackbar.show({
	        text: 'Role already exists',
	        pos: 'top-center'
    	});
	}
	else if(type==7)
	{
	    Snackbar.show({
	        text: 'Position already exists',
	        pos: 'top-center'
    	});
	}
	else if(type==8)
	{
	    Snackbar.show({
	        text: 'User registered successfully',
	        pos: 'top-center'
    	});
	}
	else if(type==9)
	{
	    Snackbar.show({
	        text: 'Data updated successfully',
	        pos: 'top-center'
    	});
	}
	else if(type==10)
	{
	    Snackbar.show({
	        text: 'User already exists',
	        pos: 'top-center'
    	});
	}
	else if(type==11)
	{
	    Snackbar.show({
	        text: 'Select Division/District & Forest Land Type',
	        pos: 'top-center'
    	});
	}
	else if(type==12)
	{
	    Snackbar.show({
	        text: 'Give Latitude and Longitude',
	        pos: 'top-center'
    	});
	}
	else if(type==13)
	{
	    Snackbar.show({
	        text: 'Data Not Available ',
	        pos: 'top-center'
    	});
	}
}

function costumeNotification(message)
{
	Snackbar.show({
	        text:message ,
	        pos: 'top-center'
    	});
}
