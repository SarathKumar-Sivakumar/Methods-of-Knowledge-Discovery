

<%@page import="java.lang.*" import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

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


<font color="white"><title>Genesis</title></font>
</head>

<body background="images/healthcare.jpg">
	<img align="middle" src="images/GenesisTheBirth-Logo.png" height="100"
		width="300" />

	<FORM ACTION="results.jsp" method="post">
		<font face="Apple Chancery" size="4px" color="white">
			<table border="4">

				<%
					ArrayList<String> adiagcode = new ArrayList<String>();
					ArrayList<String> age = new ArrayList<String>();
					try {
						//Connecting to MySQL database
						Class.forName("com.mysql.jdbc.Driver");
						String url = "jdbc:mysql://127.0.0.1:3306/healthcare";
						Connection connection = DriverManager.getConnection(url,
								"root", "root");
						String query1 = "select DISTINCT Admitting_Diagnosis_Code from healthcare order by Admitting_Diagnosis_Code;";
						String query2 = "select DISTINCT Age from healthcare order by Age; ";
						Statement st = null;
						st = connection.createStatement();
						ResultSet rs = st.executeQuery(query1);

						while (rs.next()) {

							adiagcode.add(rs.getString("Admitting_Diagnosis_Code"));
						}

						Statement st1 = null;
						st1 = connection.createStatement();
						ResultSet rs1 = st1.executeQuery(query2);

						while (rs1.next()) {

							age.add(rs1.getString("Age"));

						}

					} catch (Exception e) {

						System.out.println(e.getMessage());
					}

					int size = adiagcode.size();

					//Adding admitting Diagnoses to the dropdown
				%>
				<tr>
					<td><label> Admitting Diagnosis </label></td>
					<td><select name="AdmittingDiagnosis"
						style="width: 150px; height: 150px">
							<%
								for (int i = 0; i < size; i++) {
									String s = (String) adiagcode.get(i);
							%>
							<option value="<%=s%>"><%=s%></option>
							<%
								}
							%>
					</select></td>
				</tr>
				<br>
				<br>
				<tr>
					<td><label> Gender </label></td>
					<td><select name="Gender" style="width: 150px">
							<option value="Male">Male</option>
							<option value="Female">Female</option>
					</select></td>
				</tr>
				<tr>
					<td><label> Age Group </label></td>
					<td><select name="AgeGroup" style="width: 150px">
							<%
								//Adding Age groups to the dropdown
								int size1 = age.size();
								for (int i = 0; i < size1; i++) {
									String s1 = (String) age.get(i);
							%>
							<option value="<%=s1%>"><%=s1%></option>
							<%
								}
							%>
					</select></td>
				</tr>


			</table> <br> <input type="submit" value="Get Results" id="button-1"
			style="width: 170px; margin-left: 2em">
		</font>
	</FORM>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<form action="topten.jsp">
		<input type="submit" value="View Top AdDiagnoses" id="button-1"
			style="width: 250px; margin-left: 55em">
	</form>

	<form action="features.jsp">
		<input type="submit" value="Feature Selection" id="button-1"
			style="width: 250px; margin-left: 55em">
	</form>

	<form action="cusum.jsp">
		<input type="submit" value="Cumulative Sum" id="button-1"
			style="width: 250px; margin-left: 55em">
	</form>



</body>
</html>