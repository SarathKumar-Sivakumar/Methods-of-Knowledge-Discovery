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

		<FORM ACTION="home.jsp" method="post">
			<input type="submit" value="Home Page" id="button-1"
				style="width: 170px; margin-left: 52em">
			<h2 align="center">TOP TEN ADMISSION DIAGNOSES</h2>
			<h4 align="center">Highest Death on Discharge Ratio</h4>
			<table align="center" border="1">

				<%
					ArrayList<String> results = new ArrayList<String>();

					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://127.0.0.1:3306/healthcare";
					Connection connection = DriverManager.getConnection(url, "root",
							"root");

					//HIGHEST DEATH ON DISCHARGE RATIO - TOP TEN
					String query1 = "SELECT A.ADMITTING_DIAGNOSIS_CODE, B.y/A.x AS DISCHARGE_RATIO FROM (SELECT ADMITTING_DIAGNOSIS_CODE,COUNT(ADMITTING_DIAGNOSIS_CODE) AS x FROM HEALTHCARE GROUP BY ADMITTING_DIAGNOSIS_CODE) A  JOIN (SELECT ADMITTING_DIAGNOSIS_CODE,COUNT(ADMITTING_DIAGNOSIS_CODE) AS BDM,COUNT(DISCHARGE_STATUS) AS y FROM HEALTHCARE WHERE DISCHARGE_STATUS='B' GROUP BY ADMITTING_DIAGNOSIS_CODE,DISCHARGE_STATUS) B ON A.ADMITTING_DIAGNOSIS_CODE = B.ADMITTING_DIAGNOSIS_CODE ORDER BY DISCHARGE_RATIO DESC LIMIT 10;";

					Statement st = null;
					st = connection.createStatement();
					ResultSet rs = st.executeQuery(query1);
				%>

				<TABLE BORDER="1" align="center">
					<TR>
						<TH>Admitting Diagnosis Code</TH>
						<TH>Death Discharge Ratio</TH>
					</TR>

					<%
						while (rs.next()) {
					%>

					<TR>

						<td><%=rs.getString(1)%></td>
						<td><%=rs.getString(2)%></td>

					</TR>

					<%
						}
					%>

				</table>

				<br>
				<br>
				<br>
				<br>


				<h4 align="center">Most Expensive Admission Diagnoses</h4>
				<%
					//MOST EXPENSIVE DIAGNOSES - TOP TEN
					String query2 = "select Admitting_Diagnosis_Code,Total_Charges from healthcare order by Total_Charges desc LIMIT 10;";

					Statement st2 = null;
					st2 = connection.createStatement();
					ResultSet rs2 = st2.executeQuery(query2);
				%>
				<TABLE BORDER="1" align="center">
					<TR>
						<TH>Admitting Diagnosis Code</TH>
						<TH>Average Total Charges</TH>
					</TR>
					<%
						while (rs2.next()) {
					%>


					<TR>

						<td><%=rs2.getString(1)%></td>
						<td><%=rs2.getString(2)%></td>

					</TR>

					<%
						}
					%>

				</table>

				<br>
				<br>
				<br>
				<br>

				<h4 align="center">Highest Average Length of Stay</h4>
				<%
					//HIGHEST AVERAGE LENGTH OF STAY - TOP TEN
					String query3 = "select Admitting_Diagnosis_Code,avg(Length_Of_Stay) as Average_Length_Stay from healthcare group by Admitting_Diagnosis_Code  order by avg(Length_Of_Stay) desc LIMIT 10;";

					Statement st3 = null;
					st3 = connection.createStatement();
					ResultSet rs3 = st2.executeQuery(query3);
				%>

				<table BORDER="1" align="center">
					<TR>
						<TH>Admitting Diagnosis Code</TH>
						<TH>Average Length of Stay</TH>
					</TR>

					<%
						while (rs3.next()) {
					%>


					<TR>

						<td><%=rs3.getString(1)%></td>
						<td><%=rs3.getString(2)%></td>

					</TR>

					<%
						}
					%>

				</table>


				</FORM>
				</font>
</body>
</html>