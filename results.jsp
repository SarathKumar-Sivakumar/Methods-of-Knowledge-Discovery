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

			<h2 align="center">RESULTS</h2>

			<table align="center" border="1">

				<%
					ArrayList<String> results = new ArrayList<String>();
					String agegroup = request.getParameter("AgeGroup");
					String result1 = "";
					String result2 = "";
					String result3 = "";
					String result4 = "";
					String result5 = "";
					String result6 = "";
					float deviation_ratio_1 = 0;
					float absolute_difference = 0;
					float deviation_ratio_2 = 0;
					float absolute_difference_2 = 0;
					String gender = request.getParameter("Gender");
					String adiagcode = request.getParameter("AdmittingDiagnosis");
					int genderint = 0;

					if (gender.equals("Male")) {

						gender = "1";
						genderint = Integer.parseInt(gender);
					}

					if (gender.equals("Female")) {

						gender = "2";
						genderint = Integer.parseInt(gender);
					}

					//Connecting to the database
					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://127.0.0.1:3306/healthcare";
					Connection connection = DriverManager.getConnection(url, "root",
							"root");

					//AVERAGE LENGTH OF STAY
					String query1 = "select Avg(Length_of_Stay) as avg from healthcare where Age = "
							+ agegroup
							+ " and Sex ="
							+ gender
							+ " and Admitting_Diagnosis_Code =" + adiagcode;

					//AVERAGE LENGTH OF STAY FOR ALL ADMITTING DIAGNOSIS CODES
					String query2 = "select Avg(Length_of_Stay) as avg from healthcare where Age = "
							+ agegroup + " and Sex =" + gender;

					//PERCENTAGE OF PEOPLE DEAD
					String query3 = "SELECT COALESCE(V.TOTAL / t.cnt * 100,0) AS percentage_dead FROM (SELECT COUNT(Discharge_Status) AS TOTAL FROM healthcare WHERE DISCHARGE_STATUS='B'  and Age ="
							+ agegroup
							+ " and Sex ="
							+ gender
							+ " and Admitting_Diagnosis_Code ="
							+ adiagcode
							+ ") V JOIN (SELECT COUNT(1) AS cnt FROM healthcare  where Age ="
							+ agegroup
							+ " and Sex ="
							+ gender
							+ " and Admitting_Diagnosis_Code =" + adiagcode + ") t;";

					//PERCENTAGE OF PEOPLE ALIVE
					String query4 = "SELECT COALESCE(V.TOTAL / t.cnt * 100,0) AS percentage_alive FROM (SELECT COUNT(Discharge_Status) AS TOTAL FROM healthcare WHERE DISCHARGE_STATUS='A'  and Age ="
							+ agegroup
							+ " and Sex ="
							+ gender
							+ " and Admitting_Diagnosis_Code ="
							+ adiagcode
							+ ") V JOIN (SELECT COUNT(1) AS cnt FROM healthcare  where Age ="
							+ agegroup
							+ " and Sex ="
							+ gender
							+ " and Admitting_Diagnosis_Code =" + adiagcode + ") t;";

					//PERCENTAGE OF PEOPLE DEAD FOR ALL ADMITTING DIAGNOSIS CODES
					String query5 = "SELECT COALESCE(V.TOTAL / t.cnt * 100,0) AS percentage_dead_all FROM (SELECT COUNT(Discharge_Status) AS TOTAL FROM healthcare WHERE DISCHARGE_STATUS='B'  and Age ="
							+ agegroup
							+ " and Sex ="
							+ gender
							+ ") V JOIN (SELECT COUNT(1) AS cnt FROM healthcare  where Age ="
							+ agegroup + " and Sex =" + gender + ") t;";

					//PERCENTAGE OF PEOPLE ALIVE FOR ALL ADMITTING DIAGNOSIS CODES
					String query6 = "SELECT COALESCE(V.TOTAL / t.cnt * 100,0) AS percentage_alive_all FROM (SELECT COUNT(Discharge_Status) AS TOTAL FROM healthcare WHERE DISCHARGE_STATUS='A'  and Age ="
							+ agegroup
							+ " and Sex ="
							+ gender
							+ ") V JOIN (SELECT COUNT(1) AS cnt FROM healthcare  where Age ="
							+ agegroup + " and Sex =" + gender + ") t;";

					//AVERAGE TOTAL CHARGES
					String query7 = "select avg(Total_Charges) as Average_Total_Charges from healthcare where Age ="
							+ agegroup
							+ " and Sex ="
							+ gender
							+ " and Admitting_Diagnosis_Code =" + adiagcode;

					//AVERAGE TOTAL CHARGES FOR ALL ADMITTING DIAGNOSIS CODES
					String query8 = "select avg(Total_Charges) as Average_Total_Charges from healthcare where Age ="
							+ agegroup + " and Sex =" + gender;

					//NUMBER OF PEOPLE DEAD
					String query9 = "SELECT V.TOTAL AS no_people_dead FROM (SELECT COUNT(Discharge_Status) AS TOTAL FROM healthcare WHERE DISCHARGE_STATUS='B'  and Age ="
							+ agegroup
							+ " and Sex ="
							+ gender
							+ " and Admitting_Diagnosis_Code =" + adiagcode + ") V;";

					//NUMBER OF PEOPLE ALIVE 
					String query10 = "SELECT V.TOTAL AS no_people_alive FROM (SELECT COUNT(Discharge_Status) AS TOTAL FROM healthcare WHERE DISCHARGE_STATUS='A'  and Age ="
							+ agegroup
							+ " and Sex ="
							+ gender
							+ " and Admitting_Diagnosis_Code =" + adiagcode + ") V;";

					//NUMBER OF PEOPLE DEAD FOR ALL ADMITTING DIAGNOSIS CODES
					String query11 = "SELECT V.TOTAL AS no_people_dead_all FROM (SELECT COUNT(Discharge_Status) AS TOTAL FROM healthcare WHERE DISCHARGE_STATUS='B'  and Age ="
							+ agegroup + " and Sex =" + gender + ") V;";

					//NUMBER OF PEOPLE ALIVE FOR ALL ADMITTING DIAGNOSIS CODES
					String query12 = "SELECT V.TOTAL AS no_people_alive_all FROM (SELECT COUNT(Discharge_Status) AS TOTAL FROM healthcare WHERE DISCHARGE_STATUS='A'  and Age ="
							+ agegroup + " and Sex =" + gender + ") V;";

					Statement st = null;
					st = connection.createStatement();
					ResultSet rs = st.executeQuery(query1);

					Statement st1 = null;
					st1 = connection.createStatement();
					ResultSet rs1 = st1.executeQuery(query2);

					Statement st2 = null;
					st2 = connection.createStatement();
					ResultSet rs2 = st2.executeQuery(query3);

					Statement st3 = null;
					st3 = connection.createStatement();
					ResultSet rs3 = st3.executeQuery(query4);

					Statement st4 = null;
					st4 = connection.createStatement();
					ResultSet rs4 = st4.executeQuery(query5);

					Statement st5 = null;
					st5 = connection.createStatement();
					ResultSet rs5 = st5.executeQuery(query6);

					Statement st6 = null;
					st6 = connection.createStatement();
					ResultSet rs6 = st6.executeQuery(query7);

					Statement st7 = null;
					st7 = connection.createStatement();
					ResultSet rs7 = st7.executeQuery(query8);

					Statement st8 = null;
					st8 = connection.createStatement();
					ResultSet rs8 = st8.executeQuery(query9);

					Statement st9 = null;
					st9 = connection.createStatement();
					ResultSet rs9 = st9.executeQuery(query10);

					Statement st10 = null;
					st10 = connection.createStatement();
					ResultSet rs10 = st10.executeQuery(query11);

					Statement st11 = null;
					st11 = connection.createStatement();
					ResultSet rs11 = st11.executeQuery(query12);
				%>
				<TABLE BORDER="1">
					<TR>
						<TH>Avg Length of Stay</TH>
						<TH>Avg Length of Stay (All)</TH>
						<TH>Deviation Ratio (%)</TH>
						<TH>Absolute Difference</TH>
					</TR>

					<%
						while (rs.next()) {

							result1 = rs.getString(1);
							if (result1 == null) {

								result1 = "0";
							}
					%>
					<TR>

						<td><%=result1%></td>

						<%
							}
							while (rs1.next()) {
								result2 = rs1.getString(1);
								if (result2 == null) {

									result2 = "0";
								}
						%>

						<td><%=result2%></td>
						<%
							}

							if (result1 == null) {
								result1 = "0";
								deviation_ratio_1 = 0;
								absolute_difference = 0;
							}
							if (result2 == null) {
								result2 = "0";
								deviation_ratio_1 = 0;
								absolute_difference = 0;
							} else {
								deviation_ratio_1 = (float) (Double.parseDouble(result1) * 100 / Double
										.parseDouble(result2));
								absolute_difference = (float) Math.abs(Double
										.parseDouble(result1) - Double.parseDouble(result2));
							}
						%>


						<td><%=deviation_ratio_1%></td>
						<td><%=absolute_difference%></td>
					</TR>


				</TABLE>

				<br>
				<br>

				<TABLE BORDER="1">
					<TR>
						<TH>People Dead (%)</TH>
						<TH>People Alive (%)</TH>
						<TH>People Dead (All)</TH>
						<TH>People Alive (All)</TH>
						<TH>Deviation Ratio-Dead (%)</TH>
						<TH>Absolute Difference - Dead</TH>
						<TH>Deviation Ratio-Alive (%)</TH>
						<TH>Absolute Difference-Alive</TH>
					</TR>
					<%
						while (rs2.next()) {
							result1 = rs2.getString(1);
							if (result1 == null) {
								result1 = "0";

							}
					%>
					<TR>
						<td><%=result1%></td>
						<%
							}
						%>
						<%
							while (rs3.next()) {
								String rs123 = rs3.getString(1);
								if (rs123 == null) {
									rs123 = "0";

								}
						%>
						<td><%=rs123%></td>

						<%
							}

							while (rs4.next()) {
								result2 = rs4.getString(1);
								if (result2 == null) {
									result2 = "0";

								}
						%>
						<td><%=result2%></td>
						<%
							}

							while (rs5.next()) {
								String rs345 = rs5.getString(1);
								if (rs345 == null) {
									rs345 = "0";

								}
						%>
						<td><%=rs345%></td>
						<%
							}

							String rs456 = null;
							while (rs8.next()) {
								rs456 = rs8.getString(1);
								if (rs456 == null) {
									rs456 = "0";

								}

							}

							String rs567 = null;
							while (rs9.next()) {
								rs567 = rs9.getString(1);
								if (rs567 == null) {
									rs567 = "0";

								}
							}

							String rs678 = null;
							while (rs10.next()) {
								rs678 = rs10.getString(1);
								if (rs678 == null) {
									rs678 = "0";

								}

							}
							String rs789 = null;
							while (rs11.next()) {
								rs789 = rs11.getString(1);
								if (rs789 == null) {
									rs789 = "0";

								}

							}

							if (rs456 == null) {
								rs456 = "0";
								deviation_ratio_1 = 0;
								absolute_difference = 0;
							}
							if (rs678 == null) {
								rs678 = "0";
								deviation_ratio_1 = 0;
								absolute_difference = 0;
							} else {
								deviation_ratio_1 = (float) (Double.parseDouble(rs456) * 100 / Double
										.parseDouble(rs678));
								absolute_difference = (float) Math.abs(Double
										.parseDouble(rs456) - Double.parseDouble(rs678));
							}

							if (rs567 == null) {
								rs567 = "0";
								deviation_ratio_2 = 0;
								absolute_difference_2 = 0;
							}
							if (rs789 == null) {
								rs789 = "0";
								deviation_ratio_2 = 0;
								absolute_difference_2 = 0;
							} else {
								deviation_ratio_2 = (float) (Double.parseDouble(rs567) * 100 / Double
										.parseDouble(rs789));
								absolute_difference_2 = (float) Math.abs(Double
										.parseDouble(rs567) - Double.parseDouble(rs789));
							}
						%>

						<td><%=deviation_ratio_1%></td>
						<td><%=absolute_difference%></td>
						<td><%=deviation_ratio_2%></td>
						<td><%=absolute_difference_2%></td>


					</TR>

				</TABLE>
				<br>
				<br>

				<TABLE BORDER="1">
					<TR>
						<TH>Avg Total Cost</TH>
						<TH>Avg Total Cost (All)</TH>
						<TH>Deviation Ratio (%)</TH>
						<TH>Absolute Difference</TH>
					</TR>
					<%
						while (rs6.next()) {
							result1 = rs6.getString(1);
							if (result1 == null) {
								result1 = "0";
							}
					%>
					<TR>

						<td><%=result1%></td>

						<%
							}
						%>

						<%
							while (rs7.next()) {
								result2 = rs7.getString(1);
								if (result2 == null) {
									result2 = "0";
								}
						%>

						<td><%=result2%></td>
						<%
							}
							if (result1 == null) {
								result1 = "0";
								deviation_ratio_1 = 0;
								absolute_difference = 0;
							}
							if (result2 == null) {
								result2 = "0";
								deviation_ratio_1 = 0;
								absolute_difference = 0;
							} else {
								deviation_ratio_1 = (float) (Double.parseDouble(result1) * 100 / Double
										.parseDouble(result2));
								absolute_difference = (float) Math.abs(Double
										.parseDouble(result1) - Double.parseDouble(result2));
							}
						%>


						<td><%=deviation_ratio_1%></td>
						<td><%=absolute_difference%></td>
					</TR>
				</TABLE>

				<input type="submit" value="Go Back" id="button-2">

				</FORM>
				</font>
</body>
</html>