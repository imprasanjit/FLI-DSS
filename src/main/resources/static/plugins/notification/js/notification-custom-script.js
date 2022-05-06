  
		/* Default Notifications */
		//---Added by Bidyashree on 25.2.2019 for the purpose of notification.---//
		function Notify(element)
		{
			//Add data
			if(element==1)
			{
				Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Data has been saved successfully.'
					});
			}
			//Update data
			else if(element==2)
			{
				Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Data has been updated successfully.'
					});
			}
			//Error
			else if(element==3)
			{
				Lobibox.notify('error', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Something went wrong! Try again.'
					});
			}
			else if(element==4)
			{
				Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Data has been deleted successfully.'
					});
			}
			else if(element==5)
			{
				Lobibox.notify('warning', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'User already exist.'
					});
			}
			else if(element==6)
			{
				Lobibox.notify('warning', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'File not selected.'
					});
			}
			else if(element==7)
			{
				Lobibox.notify('warning', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Upload .pdf file only.'
					});
			}
			else if(element==8)
			{
				Lobibox.notify('warning', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Upload .kml file only.'
					});
			}
			else if(element==9)
			{
				Lobibox.notify('warning', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Already exist.'
					});
			}
			//User Active
			else if(element==10)
			{
				Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'User Active Status Updated.'
					});
			}			
			
			//File Download
			else if(element==11)
			{
				Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'File download has been started.'
					});
			}
			//Verification approval
			else if(element==12)
			{
				Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Forest block has been successfully passed the verification.'
					});
			}
			//Verification rejection
			else if(element==13)
			{
				Lobibox.notify('warning', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Forest block has been rejected.'
					});
			}
			//Import Proposed and Existing Pillar
			//User Active
			else if(element==14)
			{
				Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Excel File Imported Successfully.'
					});
			}
			else if(element==15)
			{
				Lobibox.notify('error', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Invalid File!'
					});
			} 
			//OTP confirmation
			else if(element==16)
			{
				Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'OTP has been sent to registered mobile no.'
					});
			}
			//Share data
			else if(element==17)
			{
				Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Data has been shared successfully.'
					});
			}
				//Check RTX Header Size
				else if(element==18)
				{
					Lobibox.notify('error', {
						pauseDelayOnHover: true,
								continueDelayOnInactiveTab: false,
						position: 'center top',
						showClass: 'fadeInDown',
								hideClass: 'fadeOutDown',
								width: 600,
						msg: 'Length of csv file is not matched with RTX file format.'
						});
				}
			//Check RTX Format
			else if(element==19)
			{
				Lobibox.notify('error', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Invalid File! File Header does not match with valid RTX File.'
					});
			}

			//attribute point not available in DB
			else if(element==20)
			{
				Lobibox.notify('error', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					// showClass: 'fadeInDown',
					// 		hideClass: 'fadeOutDown',
							width: 600,
					msg:  "Missing attribute data of point "+$("#hdntotalpoints").val()+". Please Contact to SLTP Coordinator."
					});
			}
			else if(element==21)
			{
				Lobibox.notify('error', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					// showClass: 'fadeInDown',
					// 		hideClass: 'fadeOutDown',
							width: 600,
					msg:  "Something went wrong in Pillar No "+$("#hdntotalpoints").val()+". Please Check your file and upload again!!!."
					});
				
			}
			//Lat Long Validation
			else if(element==22)
			{
				Lobibox.notify('error', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Latitude and Longitude value must be 8 digit after decimal point.'
					});
			} 
			//Lat Long Validation
			else if(element==23)
			{
				Lobibox.notify('error', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: 'Common Pillar Already Inserted'
					});
			} 
		}
		function AlertNotify(alertToUser)
		{
			//Specific alert to user
					Lobibox.notify('warning', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: alertToUser
					});
		
		}
		function AlertSuccess(alertToUser)
		{
			//Specific alert to user
					Lobibox.notify('success', {
					pauseDelayOnHover: true,
							continueDelayOnInactiveTab: false,
					position: 'center top',
					showClass: 'fadeInDown',
							hideClass: 'fadeOutDown',
							width: 600,
					msg: alertToUser
					});
		
		}
//---Ended  by Bidyashree on 25.2.2019 for the purpose of notification.---//

         function default_noti(){
			Lobibox.notify('default', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }


        function info_noti(){
			Lobibox.notify('info', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    icon: 'fa fa-info-circle',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }

        function warning_noti(){
			Lobibox.notify('warning', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    icon: 'fa fa-exclamation-circle',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 

		  function error_noti(){
			Lobibox.notify('error', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    icon: 'fa fa-times-circle',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 

		  function success_noti(){
			Lobibox.notify('success', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    icon: 'fa fa-check-circle',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 




/* Rounded corners Notifications */

         function round_default_noti(){
			Lobibox.notify('default', {
		    pauseDelayOnHover: true,
		    size: 'mini',
		    rounded: true,
		    delayIndicator: false,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }


        function round_info_noti(){
			Lobibox.notify('info', {
		    pauseDelayOnHover: true,
		    size: 'mini',
		    rounded: true,
		    icon: 'fa fa-info-circle',
		    delayIndicator: false,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }

        function round_warning_noti(){
			Lobibox.notify('warning', {
		    pauseDelayOnHover: true,
		    size: 'mini',
		    rounded: true,
		    delayIndicator: false,
		    icon: 'fa fa-exclamation-circle',
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 

		  function round_error_noti(){
			Lobibox.notify('error', {
		    pauseDelayOnHover: true,
		    size: 'mini',
		    rounded: true,
		    delayIndicator: false,
		    icon: 'fa fa-times-circle',
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 

		  function round_success_noti(){
			Lobibox.notify('success', {
		    pauseDelayOnHover: true,
		    size: 'mini',
		    rounded: true,
		    icon: 'fa fa-check-circle',
		    delayIndicator: false,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 




     /* Notifications With Images*/

         function img_default_noti(){
			Lobibox.notify('default', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    img: 'assets/plugins/notifications/img/1.jpg', //path to image
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }


        function img_info_noti(){
			Lobibox.notify('info', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
            icon: 'fa fa-info-circle',
		    position: 'top right',
		    img: 'assets/plugins/notifications/img/2.jpg', //path to image
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }

        function img_warning_noti(){
			Lobibox.notify('warning', {
		    pauseDelayOnHover: true,
		    icon: 'fa fa-exclamation-circle',
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    img: 'assets/plugins/notifications/img/3.jpg', //path to image
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 

		  function img_error_noti(){
			Lobibox.notify('error', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
            icon: 'fa fa-times-circle',
		    position: 'top right',
		    img: 'assets/plugins/notifications/img/4.jpg', //path to image
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 

		  function img_success_noti(){
			Lobibox.notify('success', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    icon: 'fa fa-check-circle',
		    img: 'assets/plugins/notifications/img/5.jpg', //path to image
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 
		 




     /* Notifications With Images*/


      function pos1_default_noti(){
			Lobibox.notify('default', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'center top',
		    size: 'mini',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }

        function pos2_info_noti(){
			Lobibox.notify('info', {
		    pauseDelayOnHover: true,
		    icon: 'fa fa-info-circle',
            continueDelayOnInactiveTab: false,
		    position: 'top left',
		    size: 'mini',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }

        function pos3_warning_noti(){
			Lobibox.notify('warning', {
		    pauseDelayOnHover: true,
		    icon: 'fa fa-exclamation-circle',
            continueDelayOnInactiveTab: false,
		    position: 'top right',
		    size: 'mini',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 

		  function pos4_error_noti(){
			Lobibox.notify('error', {
		    pauseDelayOnHover: true,
		    icon: 'fa fa-times-circle',
		    size: 'mini',
            continueDelayOnInactiveTab: false,
		    position: 'bottom left',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }		 

		  function pos5_success_noti(){
			Lobibox.notify('success', {
		    pauseDelayOnHover: true,
		    size: 'mini',
		    icon: 'fa fa-check-circle',
            continueDelayOnInactiveTab: false,
		    position: 'bottom right',
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }	




     /* Animated Notifications*/


      function anim1_noti(){
			Lobibox.notify('default', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'center top',
		    showClass: 'fadeInDown',
            hideClass: 'fadeOutDown',
            width: 600,
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }


		  function anim2_noti(){
			Lobibox.notify('info', {
		    pauseDelayOnHover: true,
		    icon: 'fa fa-info-circle',
            continueDelayOnInactiveTab: false,
		    position: 'center top',
		    showClass: 'bounceIn',
            hideClass: 'bounceOut',
            width: 600,
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }

		  function anim3_noti(){
			Lobibox.notify('warning', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
            icon: 'fa fa-exclamation-circle',
		    position: 'center top',
		    showClass: 'zoomIn',
            hideClass: 'zoomOut',
            width: 600,
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }

		  function anim4_noti(){
			Lobibox.notify('error', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
            icon: 'fa fa-times-circle',
		    position: 'center top',
		    showClass: 'lightSpeedIn',
            hideClass: 'lightSpeedOut',
            width: 600,
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }

		  function anim5_noti(){
			Lobibox.notify('success', {
		    pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
		    position: 'center top',
		    showClass: 'rollIn',
            hideClass: 'rollOut',
            icon: 'fa fa-check-circle',
            width: 600,
		    msg: 'Lorem ipsum dolor sit amet hears farmer indemnity inherent.'
		    });
		  }