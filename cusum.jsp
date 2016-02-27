<%@page import="java.lang.*" import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<font color="white"><title>Genesis</title></font>
<link
	href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
	rel="stylesheet">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script>
         $(function() {
            $( "#button-1, #button-2, #button-3, #button-4" ).button();
            $( "#button-5" ).buttonset();
         });
      </script>
</head>

<body background="images/healthcare1.jpg">
	<font face="Apple Chancery" size="4px"> <img align="middle"
		src="images/GenesisTheBirth-Logo.png" height="100" width="300" />



		<FORM ACTION="cusumoutput.jsp" method="post">

			<label> Please enter values representing the temporal dataset</label><br>
			Value 1 <input type="text" name="value1"><br> Value 2<input
				type="text" name="value2"><br> Value 3<input
				type="text" name="value3"><br> Value 4<input
				type="text" name="value4"><br> Value 5<input
				type="text" name="value5"><br> Value 6<input
				type="text" name="value6"><br> Value 7<input
				type="text" name="value7"><br> Value 8<input
				type="text" name="value8"><br> Value 9<input
				type="text" name="value9"><br> Value 10<input
				type="text" name="value10"><br> Value 11<input
				type="text" name="value11"><br> Value 12<input
				type="text" name="value12"><br> Value 13<input
				type="text" name="value13"><br> Value 14<input
				type="text" name="value14"><br> Value 15<input
				type="text" name="value15"><br> Value 16<input
				type="text" name="value16"><br> Value 17<input
				type="text" name="value17"><br> Value 18<input
				type="text" name="value18"><br> Value 19<input
				type="text" name="value19"><br> Value 20<input
				type="text" name="value20"><br> <br>
			<br> Reference Mean <input type="text" name="mean"><br>
			Reference Standard Deviation <input type="text" name="deviation"><br>
			Sigma <input type="text" name="sigma"><br> <input
				type="submit" name="Show Data Points" value="showdatapoints"
				id="button-1">
		</FORM>
	</font>
</body>
</html>