<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "p" %>
<!DOCTYPE html>
<html lang="en">
    
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>FLIDSS</title>
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
       
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet"> 
        <!-- Font Awesome -->
        <link rel="stylesheet" href="fonts/css/font-awesome.min.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="assets/css/home.styles.css" rel="stylesheet" />

        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="https://fonts.googleapis.com/css?family=Nunito:400,600,700" rel="stylesheet">
        <!-- <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" /> -->
        <link href="assets/css/plugins.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/authentication/form-1.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <link rel="stylesheet" type="text/css" href="assets/css/forms/theme-checkbox-radio.css">
        <link rel="stylesheet" type="text/css" href="assets/css/forms/switches.css">
    </head>
    <body id="page-top" class="form">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container-fluid">
                <a class="navbar-brand js-scroll-trigger" href="#page-top"><img src="assets/img/logo.png" alt="" /></a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fa fa-bars ml-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ml-auto">
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#mainHeader">Home</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#about">About</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#contact">Contact</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Masthead-->
        <header class="masthead login-block" id="mainHeader">
            <div class="container">
                <!-- <div class="masthead-subheading">Welcome To Our Studio!</div>
                <div class="masthead-heading text-uppercase">It's Nice To Meet You</div>
                <a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger" href="#services">Tell Me More</a> -->
                <div class="row">

                    <div class="col-md-12 banner-sec">
                        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="5"></li>
                            </ol>
                            <div class="carousel-inner" role="listbox">
                                <div class="carousel-item active">
                                    <img class="d-block img-fluid" src="assets/img/slider/1.jpg" alt="First slide">
                                    <div class="carousel-caption d-md-block">
                                        <div class="banner-text">
                                            <h2>
                                                Forest Land Information &<br>
                                                Decision Support System
                                            </h2>
                                            <!-- <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit,<br>
                                                sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br>
                                                Ut enim ad minim veniam, quis nostrud exercitation
                                            </p> -->
                                        </div>  
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block img-fluid" src="assets/img/slider/2.jpg" alt="Second slide">
                                    <div class="carousel-caption d-md-block">
                                        <div class="banner-text">
                                            <h2>
                                                Forest Land Information &<br>
                                                Decision Support System
                                            </h2>
                                            <!-- <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit,<br>
                                                sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br>
                                                Ut enim ad minim veniam, quis nostrud exercitation
                                            </p> -->
                                        </div>  
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block img-fluid" src="assets/img/slider/3.jpg" alt="Third slide">
                                    <div class="carousel-caption d-md-block">
                                        <div class="banner-text">
                                            <h2>
                                                Forest Land Information &<br>
                                                Decision Support System
                                            </h2>
                                            <!-- <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit,<br>
                                                sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br>
                                                Ut enim ad minim veniam, quis nostrud exercitation
                                            </p> -->
                                        </div>  
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block img-fluid" src="assets/img/slider/4.jpg" alt="Forth slide">
                                    <div class="carousel-caption d-md-block">
                                        <div class="banner-text">
                                            <h2>
                                                Forest Land Information &<br>
                                                Decision Support System
                                            </h2>
                                            <!-- <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit,<br>
                                                sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br>
                                                Ut enim ad minim veniam, quis nostrud exercitation
                                            </p> -->
                                        </div>  
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block img-fluid" src="assets/img/slider/5.jpg" alt="Fifth slide">
                                    <div class="carousel-caption d-md-block">
                                        <div class="banner-text">
                                            <h2>
                                                Forest Land Information &<br>
                                                Decision Support System
                                            </h2>
                                            <!-- <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit,<br>
                                                sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br>
                                                Ut enim ad minim veniam, quis nostrud exercitation
                                            </p> -->
                                        </div>  
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block img-fluid" src="assets/img/slider/6.jpg" alt="Sixth slide">
                                    <div class="carousel-caption d-md-block">
                                        <div class="banner-text">
                                            <h2>
                                                Forest Land Information &<br>
                                                Decision Support System
                                            </h2>
                                            <!-- <p>
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit,<br>
                                                sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.<br>
                                                Ut enim ad minim veniam, quis nostrud exercitation
                                            </p> -->
                                        </div>  
                                    </div>
                                </div>
                            </div>     
                        </div>
                    </div>

                    <div class="login-sec">

                        <div class="form-container">
                            <div class="form-form">
                                <div class="form-form-wrap">
                                    <div class="form-container">
                                        <div class="form-content">
                                             
                                            <h3 class="text-white">LOGIN</h3>
                                            <p class="signup-link">New here? <a href="#" data-toggle="modal" data-target="#createAccount">Create an account</a></p>
                                            <form class="text-left" method="POST" action="/login" >
                                                <div class="alert alert-danger">
                                                    Invalid username and password.
                                                 </div >

                                         
                                                <div class="form">

                                                    <div id="" class="field-wrapper input">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                                        <input id="txtId" name="username" type="text" class="form-control" placeholder="Username" required="true">
                                                    </div>

                                                    <div id="" class="field-wrapper input mb-2">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-lock"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                                        <input id="password"  name="password" type="password"  class="form-control" placeholder="Password" required="true">
                                                    </div>
                                                    <div class="d-sm-flex justify-content-between">
                                                        <div class="field-wrapper toggle-pass">
                                                            <p class="d-inline-block">Show Password</p>
                                                            <label class="switch s-primary">
                                                                <input type="checkbox" id="toggle-password" class="d-none">
                                                                <span class="slider round"></span>
                                                            </label>
                                                        </div>
                                                        <div class="field-wrapper">
                                                            <button id="btnLogin" type="submit" class="btn btn-success" value="">Login</button>
                                                        </div>
                                                        
                                                    </div>

                                                    <div class="field-wrapper d-auto d-block mx-auto text-center mt-3">
                                                        <a href="#" class="forgot-pass-link" data-toggle="modal" data-target="#forgotPassword">Forgot Password?
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-help-circle"><circle cx="12" cy="12" r="10"></circle><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>
                                                        </a>
                                                    </div>

                                                    <div class="field-wrapper mt-3 mb-3">
                                                        <h6 class="text-center text-white">- OR -</h6>
                                                    </div>

                                                    <div id="" class="field-wrapper input mb-2">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-tablet"><rect x="4" y="2" width="16" height="20" rx="2" ry="2"></rect><line x1="12" y1="18" x2="12.01" y2="18"></line></svg>
                                                        <input id="" name="" type="number" class="form-control" placeholder="Mobile No.">
                                                    </div>

                                                    <div class="field-wrapper text-center">
                                                        <button  type="submit" class="btn btn-success" value="">Verify</button>
                                                    </div>

                                                </div>
                                            </form>                        

                                        </div>                    
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            
        </header>
        
        <!-- About-->
        <section class="page-section" id="about">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">About</h2>
                </div>
                <img class="rounded-circle img-thumbnail img-fluid float-left mr-4" src="assets/img/about/1.jpg" alt="" />
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt ut voluptatum eius sapiente, totam reiciendis temporibus qui quibusdam, recusandae sit vero unde, sed, incidunt et ea quo dolore laudantium consectetur.</p>
                <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur. At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est</p>
            </div>
        </section>
        
        <!-- Contact-->
        <section class="page-section" id="contact">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Contact Us</h2>
                </div>
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834854.363164046!2d82.19173434761198!3d20.176767888967433!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a226aece9af3bfd%3A0x133625caa9cea81f!2sOdisha!5e0!3m2!1sen!2sin!4v1612776420982!5m2!1sen!2sin" width="100%" height="450" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-body map-info">
                                <p>
                                    <i class="info fa fa-map-marker">&nbsp;</i>
                                    123, North Street, Mancheswar, Bhubaneswar, Odisha, Pin - 751010
                                </p>
                                <p>
                                    <i class="info fa fa-phone">&nbsp;</i>
                                    0674 2445571, 2445572
                                </p>
                                <p>
                                    <i class="info fa fa-fax">&nbsp;</i>
                                    0674 2445571
                                </p>
                                <p>
                                    <i class="info fa fa-envelope">&nbsp;</i>
                                    service@flidss.com
                                </p>
                                <hr>
                                <p class="text-center">
                                    <a class="btn btn-social mx-2" href="#!"><i class="fa fa-facebook"></i></a>
                                    <a class="btn btn-social mx-2" href="#!"><i class="fa fa-linkedin"></i></a>
                                    <a class="btn btn-social mx-2" href="#!"><i class="fa fa-youtube-play"></i></a>
                                    <a class="btn btn-social mx-2" href="#!"><i class="fa fa-google-plus"></i></a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <footer class="footer py-4">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-lg-4 text-lg-left">&copy; 2021. FLIDSS. All Rights Reserved</div>
                    <div class="col-lg-8 text-lg-right">
                        Site Developed & Maintained by <a class="" href="https://www.sparcindia.com/" target="_blank">SPARC Pvt. Ltd. (SLTP)</a> & Forest IT & GIS Cell (FITGC), Odisha
                    </div>
                </div>
            </div>
        </footer>
        
        <!-- Modal Create Account-->
        <div class="portfolio-modal modal fade" id="createAccount" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">

                                    <div class="form-form">
                                        <div class="form-form-wrap">
                                            <div class="form-container">
                                                <div class="form-content">

                                                    <h3 class="mb-3">Create an Account</h3>
                                                    <form class="text-left">
                                                        <div class="form">

                                                            <div id="" class="field-wrapper input">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                                                <input id="" name="" type="text" class="form-control" placeholder="Username">
                                                            </div>

                                                            <div id="" class="field-wrapper input mb-2">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-lock"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                                                <input id="" name="" type="password" class="form-control" placeholder="Password">
                                                            </div>
                                                            <div id="" class="field-wrapper input mb-2">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-lock"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                                                <input id="" name="" type="password" class="form-control" placeholder="Confirm Password">
                                                            </div>

                                                            <div id="" class="field-wrapper input mb-2">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-tablet"><rect x="4" y="2" width="16" height="20" rx="2" ry="2"></rect><line x1="12" y1="18" x2="12.01" y2="18"></line></svg>
                                                                <input id="" name="" type="number" class="form-control" placeholder="Mobile Number">
                                                            </div>

                                                            <div class="field-wrapper text-center">
                                                                <button type="submit" class="btn btn-success" value="">Create</button>
                                                            </div>

                                                        </div>
                                                    </form>                        

                                                </div>                    
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Forgot Password-->
        <div class="portfolio-modal modal fade" id="forgotPassword" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="close-modal" data-dismiss="modal"><img src="assets/img/close-icon.svg" alt="Close modal" /></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="modal-body">

                                    <div class="form-form">
                                        <div class="form-form-wrap">
                                            <div class="form-container">
                                                <div class="form-content">

                                                    <h3 class="mb-3">Forgot Password</h3>
                                                    <form class="text-left">
                                                        <div class="form">

                                                            <div id="" class="field-wrapper input">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-mail"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                                                                <input id="" name="" type="email" class="form-control" placeholder="Enter Emai ID">
                                                            </div>

                                                            <div class="field-wrapper text-center">
                                                                <button type="submit" class="btn btn-success" value="">Submit</button>
                                                            </div>

                                                        </div>
                                                    </form>                        

                                                </div>                    
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Bootstrap core JS-->
        <script src="assets/js/home.jquery.min.js"></script>
        <script src="assets/js/home.bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="assets/js/home.jquery.easing.min.js"></script>
        <!-- Core theme JS-->
        <script src="assets/js/home.scripts.js"></script>

        <!-- BEGIN GLOBAL MANDATORY SCRIPTS -->
        <!-- <script src="assets/js/libs/jquery-3.1.1.min.js"></script> -->
        <script src="bootstrap/js/popper.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        
        <!-- END GLOBAL MANDATORY SCRIPTS -->
        <script src="assets/js/authentication/form-1.js"></script>
        <script type="text/javascript">

    
        // $("#btnLogin").click(function(){
        // 	if(($("#txtId").val()=="" && $("#password").val()=="") || ($("#txtId").val()!="" && $("#password").val()=="") || ($("#txtId").val()=="" && $("#password").val()!=""))
        // 		{
        		// <%-- var msg=<%session.getAttribute("infoBox").toString();%>
        		// console.log(msg);
        		// alert(msg); --%>
            //     alert('Username/Password should not be blank.');
        		
        	// 	}
        	// else 
        	// 	{
                    // window.location.href = '/GIS/dataCatalogue';
        		// alert("Invalid User Name or Password");
                // $.ajax({
				// 	url: '/Home',
				// 	data: {'username': $("#txtId").val(),'pwd':$("#password").val()},
				// 	contentType:"application/json;charset=utf-8",
				// 	type: 'GET',
				// 	dataType:"json",
                //     success:function () {
				// 		window.location.href = '/GIS/dataCatalogue';
				// 	},
                    
                //     error:function (xhr, status) {
				// 		alert(status);
                //         window.location.href = '/';
				// 	}
                // })
            //}
       // });
        </script>
    </body>

</html>
