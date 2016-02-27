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
		$("#button-1, #button-2, #button-3, #button-4").button();
		$("#button-5").buttonset();
	});
</script>
</head>

<body background="images/healthcare1.jpg">
	<font face="Apple Chancery" size="4px"> <img align="middle"
		src="images/GenesisTheBirth-Logo.png" height="100" width="300" />



		<FORM ACTION="rules.jsp" method="post">
			<input type="submit" value="Home Page" id="button-1"
				style="width: 170px; margin-left: 52em"> <br>
			<br>
			<br> <input type="checkbox" name="features" value="Age">Age<br>
			<input type="checkbox" name="features" value="Sex">Sex<br>
			<input type="checkbox" name="features" value="Race">Race<br>
			<input type="checkbox" name="features" value="Day_of_Admission">Day_of_Admission<br>
			<input type="checkbox" name="features" value="Discharge_Status">Discharge_Status<br>
			<input type="checkbox" name="features" value="Stay_Indicator">Stay_Indicator<br>
			<input type="checkbox" name="features" value="DRG_Code">DRG_Code<br>
			<input type="checkbox" name="features" value="Length_of_Stay">Length_of_Stay<br>
			<input type="checkbox" name="features" value="DRG_Price">DRG_Price<br>
			<input type="checkbox" name="features" value="Total_Charges">Total_Charges<br>
			<input type="checkbox" name="features" value="Covered_Charges">Covered_Charges<br>
			<input type="checkbox" name="features"
				value="POA_Diagnosis_Indicator1">POA_Diagnosis_Indicator1<br>
			<input type="checkbox" name="features"
				value="POA_Diagnosis_Indicator2">POA_Diagnosis_Indicator2<br>
			<input type="checkbox" name="features" value="Diagnosis_Code1">Diagnosis_Code1<br>
			<input type="checkbox" name="features" value="Diagnosis_Code2">Diagnosis_Code2<br>
			<input type="checkbox" name="features" value="Procedure_Code1">Procedure_Code1<br>
			<input type="checkbox" name="features" value="Procedure_Code2">Procedure_Code2<br>
			<input type="checkbox" name="features" value="Discharge_Destination">Discharge_Destination<br>
			<input type="checkbox" name="features" value="Source_of_Admission">Source_of_Admission<br>
			<input type="checkbox" name="features" value="Type_of_Admission">Type_of_Admission<br>
			<input type="checkbox" name="features"
				value="Admitting_Diagnosis_Code">Admitting_Diagnosis_Code<br>

			Minimum Support <input type="text" name="minsupport"><br>
			Minimum Confidence <input type="text" name="minconfidence"><br>

			<input type="submit" name="showrules" value="showrules" id="button-1">
		</FORM>
	</font>
</body>
</html>