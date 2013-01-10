<%--#-------------------------------------------------------------------------------
# Author : Group BBHC
# License : AGPL v3
#-------------------------------------------------------------------------------
--%>

<%@ page import="mypub.User"%>
<%@ page import="mypub.Picture"%>
<%@ page
	import="org.springframework.dao.DataIntegrityViolationException"%>
<%@ page import="grails.plugins.springsecurity.Secured"%>
<%@ page
	import="org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils"%>
<%@ page
	import="org.springframework.security.authentication.AccountExpiredException"%>
<%@ page
	import="org.springframework.security.authentication.CredentialsExpiredException"%>
<%@ page
	import="org.springframework.security.authentication.DisabledException"%>
<%@ page
	import="org.springframework.security.authentication.LockedException"%>
<%@ page
	import="org.springframework.security.core.context.SecurityContextHolder as SCH"%>
<%@ page import="org.springframework.security.web.WebAttributes"%>
<%@ page
	import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%>


<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>MyPub</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}
			#statusRight{
				min-height : 400px;
			}
			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}
            
			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 1em 1.25em 18em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
	</head>
	<body>
	<a href="#page-body" class="skip"><g:message
				code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<sec:ifLoggedIn>
		<!--<div id="status" role="complementary">
			<h1 align=center>Menu</h1>
			<g:link controller='User' action='showProfile'>My Profile</g:link><br/>
			<g:link controller='Picture' action='listPerso'>My Pictures</g:link><br/>
			<g:link controller='User' action='listFriends'>My Friends</g:link><br/>
			<g:link controller='Pub' action='list'>My Pubs</g:link><br/>
			
		</div>-->
	
			<fieldset class="buttons"> Welcome Back  <sec:username />   
				<g:link controller='User' action='showProfile'>My Profile</g:link>
				<g:link controller='Picture' action='listPerso'>My Pictures</g:link>
				<g:link controller='User' action='listFriends'>My Friends</g:link>
				<g:link controller='Pub' action='listPubs'>My Pubs</g:link>
				<g:link controller='Pub' action='list'>Pubs</g:link>
				<li style="float : right"><g:link controller='Logout'><img src="${resource(dir: 'images', file: 'skin/logout.png')}" width="15"/> Logout</g:link></li>
			</fieldset>
		 
		
		<g:set var="userNow" value="${User.findByUsername(sec.loggedInUserInfo(field:'username'))}" />
		<div align="center" id="statusRight">
		<br><br><br>
			<g:if test="${userNow?.avatar}">
					<img id="showAvatar" class="Picture" src="${createLink(controller:'Picture', action:'viewImageId', id:userNow.id)}" width="150"/>
				</g:if>
				<g:else>
					<g:if test="${userNow?.sex ==  'F'}">
					<img src="${resource(dir: 'images', file: '/pub/Avatar_woman.jpg')}" width="150"/>
					</g:if>
					<g:else>
					<img src="${resource(dir: 'images', file: '/pub/Avatar_man.jpg')}" width="150"/>
					</g:else>
				</g:else>	
				<br><br>
				You have <%out.print(userNow.friends.size().toString()) %> friend(s)<br>
				You have <%out.print(userNow.pubs.size().toString())%> pub(s)<br>
		</div>
	
	</sec:ifLoggedIn>
	

	<sec:ifNotLoggedIn>
	<div class="nav" role="navigation">
	
			<ul>
				<li><h3><g:link controller='login' action='auth'>Login</g:link></h3></li>
			</ul>
			
		</div>
	<div id="page-body" role="main">
			<h1 style="margin : 15px;">Welcome</h1>
			<br /> <br />
			<p align=justify style="margin : 15px;">Hey ! Welcome to MyPub ! Your e-community which that you can exchange your favorites pubs with your friends! Recommend, note, comment and share !</p>
			<br /> <br />
	</div>
		
		<div>
				<g:include controller="user" action="create" />
		</div>
		<!--  
		<div align=left id="status" role="main">
			<h1 align=center>Menu</h1>
			<p>
				Pour vous connecter :<br />
				<%--
				redirection vers la connexion
				--%>
				<g:link controller='login' action='auth'>Connexion</g:link>
			</p>
			<p>
			<%--
				redirection vers l'inscription
				--%>
				Pour vous inscrire :<br />
				<g:link controller='User' action='create'>Inscription</g:link>
			</p>
		</div>
		-->


		<div id="page-body" role="explain">
			
		</div>
	</sec:ifNotLoggedIn>

	</body>
</html>
