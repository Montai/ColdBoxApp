<!--- File name: Home.cfm 
	Description: It is the home page of the application
--->
<!DOCTYPE HTML>
<html>
	<head>
		<title>Home Page</title>
		<meta charset = "utf-8" />
		<meta name = "viewport" content = "width=device-width, initial-scale=1" />
		<link rel = "stylesheet" href = "../../includes/css/main.css" />
        <link rel = "stylesheet" href = "../../includes/css/topnav.css"/>
	</head>
	<body>
        <div class = "topnav">
            <a href = "Logout.cfm" onclick = "return confirm('Are you sure to log out?')">Log Out</a>
            <a href = "About.cfm">About Page</a>
        </div>
		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Header -->
					<header id="header">
                        <!--- <cfquery name = "getUserName" datasource = "cfartgallery">
                            SELECT FIRSTNAME
                            FROM USERS
                            WHERE EMAILID = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#form.emailId#">
                        </cfquery> --->
                        <!--- <cfdump  var="#form#"> --->
						<h1>This is a <strong>Home Page</strong>, of Art Gallery</h1>
						<ul class="icons">
							<li><a href="#" class="icon style2 fa-twitter"><span class="label">Twitter</span></a></li>
							<li><a href="#" class="icon style2 fa-facebook"><span class="label">Facebook</span></a></li>
							<li><a href="#" class="icon style2 fa-instagram"><span class="label">Instagram</span></a></li>
							<li><a href="#" class="icon style2 fa-500px"><span class="label">500px</span></a></li>
							<li><a href="#" class="icon style2 fa-envelope-o"><span class="label">Email</span></a></li>
						</ul>
					</header>

				<!-- Main -->
					<section id = "main">

						<!-- Thumbnails -->
							<section class="thumbnails">
								<div>
									<a href="../../includes/images/fulls/01.jpg">
										<img src="../../includes/images/thumbs/01.jpg" alt="" />
										<h3>Wallpaper1</h3>
									</a>
									<a href="../../includes/images/fulls/02.jpg">
										<img src="../../includes/images/thumbs/02.jpg" alt="" />
										<h3>Wallpaper2</h3>
									</a>
								</div>
								<div>
									<a href="../../includes/images/fulls/03.jpg">
										<img src="../../includes/images/thumbs/03.jpg" alt="" />
										<h3>Wallpaper3</h3>
									</a>
									<a href="../../includes/images/fulls/04.jpg">
										<img src="../../includes/images/thumbs/04.jpg" alt="" />
										<h3>Wallpaper4</h3>
									</a>
									<a href="../../includes/images/fulls/05.jpg">
										<img src="../../includes/images/thumbs/05.jpg" alt="" />
										<h3>Wallpaper5</h3>
									</a>
								</div>
								<div>
									<a href="../../includes/images/fulls/06.jpg">
										<img src="../../includes/images/thumbs/06.jpg" alt="" />
										<h3>Wallpaper6</h3>
									</a>
									<a href="../../includes/images/fulls/07.jpg">
										<img src="../../includes/images/thumbs/07.jpg" alt="" />
										<h3>Wallpaper7</h3>
									</a>
								</div>
							</section>

					</section>

				<!-- Footer -->
					<footer id="footer">
						<p>&copy; Untitled. All rights reserved. Design: <a href="http://templated.co">TEMPLATED</a>. Demo Images: <a href="http://unsplash.com">Unsplash</a>.</p>
					</footer>

			</div>

		<!-- Scripts -->
			<script src="../../includes/js/jquery.min.js"></script>
			<script src="../../includes/js/jquery.poptrox.min.js"></script>
			<script src="../../includes/js/skel.min.js"></script>
			<script src="../../includes/js/main.js"></script>
	</body>
</html>