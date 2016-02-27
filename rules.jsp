<%@page import="java.lang.*" import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.io.IOException"%>
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
            $( "#button-1, #button-2, #button-3, #button-4" ).button();
            $( "#button-5" ).buttonset();
         });
      </script>
</head>
<body background="images/healthcare1.jpg">

	<%
try
{
	
	//Connecting to the database
	Class.forName("com.mysql.jdbc.Driver");  
    String url="jdbc:mysql://127.0.0.1:3306/healthcare";
    Connection connection = DriverManager.getConnection(url, "root", "root");	
    Statement st6 = null;   
	st6 = connection.createStatement();
	st6.executeUpdate("DELETE FROM rulestbl");
}
  
catch(Exception e)
{
	System.out.println(e.getMessage());
	
}

    
    String csvFile = "/Users/sumanthpikkili/Desktop/6339_original.csv";
	BufferedReader br = null;
	BufferedReader br1 = null;
	String line = "";
	String line1 = "";
	String cvsSplitBy = ",";
	
	//Get all the features that the user has selected
	String featureset[] = request.getParameterValues("features");
	ArrayList<Integer> colindex1 = new ArrayList<Integer>();
	ArrayList<Integer> colindex2 = new ArrayList<Integer>();
	int length = featureset.length;
	int i = 0;
	int j = 0;
	
	//Below for loops get the combination pairs of the features
	
	for(i=0;i<length;i++)
	{
		for(j=0;j<length;j++)
		{
			if(i == j)
			continue;
			
			else
			{		
	try
	{
		Class.forName("com.mysql.jdbc.Driver");  
	    String url="jdbc:mysql://127.0.0.1:3306/healthcare";
	    Connection connection = DriverManager.getConnection(url, "root", "root");
	    Statement st = null;
	    Statement st1 = null;
	    Statement st2 = null;
	    Statement st3 = null;
	    Statement st4 = null;
	    String query = "";
	  
	    
	    String rule = "";
		br1 = new BufferedReader(new FileReader(csvFile));
		
		//Getting the column headers
		String headerline1 = br1.readLine();
		
		//Storing the column headers in a string array
		String columnsplit[] = headerline1.split(cvsSplitBy);
		

		//Getting the column indices
		for(int k=0; k<columnsplit.length;k++)
		{
			
			if(featureset[i].equals(columnsplit[k]))
			{
				colindex1.add(k);
			}
			
			if(featureset[j].equals(columnsplit[k]))
			{
				colindex2.add(k);
			}
		}

		
		
		int index1 = colindex1.get(0);

		int index2 = colindex2.get(0);

		//Read the csv file
		while ((line1 = br1.readLine()) != null) {
			
			   int result;
				int result2;
				float support;
				float confidence;
			String[] row1 = line1.split(cvsSplitBy);
			String query2 = "";
			String query3 = "";
			String query4 = "";
			String query5 = "";
			String query6 = "";
			String sub = "";

			ArrayList<Double> results = new ArrayList<Double>();
			ArrayList<Double> minimum = new ArrayList<Double>();

			
			//RULE 
			rule = row1[index1] + "----------->" + row1[index2];
			
			if(row1[index1] == "")
			{
				
				row1[index1] = "null";
			}
			
			if(row1[index2] == "")
			{
				
				row1[index2] = "null";
			}

			query2 = "select count(*) as count1 from healthcare where " + featureset[i] + "='" + row1[index1]+ "' and " + featureset[j] + "='" + row1[index2] + "' group by " + featureset[i] + "," + featureset[j] + "";

			query3 = "select count(*) as count1 from healthcare where " + featureset[i] + "='" + row1[index1]+ "'";

			st1 = connection.createStatement();
			st2 = connection.createStatement();
			ResultSet rs1 = st1.executeQuery(query2);
			
			//Calculating support
			while(rs1.next())
			{

			double support1 = (double)Integer.parseInt(rs1.getString(1)) / 1477;
			
			
			results.add(support1);

			
			}
			
			ResultSet rs2 = st2.executeQuery(query3);
			while(rs2.next())
			{

			double support2 = (double)Integer.parseInt(rs2.getString(1)) / 1477;
			double confidence1 = results.get(0) / support2;
			double minsupport = Double.parseDouble(request.getParameter("minsupport"));
			double minconfidence = Double.parseDouble(request.getParameter("minconfidence"));
			
			//Checking the bounds
			if(confidence1 >= minconfidence && results.get(0) >= minsupport )
			{
				st3 = connection.createStatement();
			    String confconverted = Double.toString(confidence1);
			    String supportconverted = Double.toString(results.get(0));
				String mainrule = featureset[i] + "------->" + featureset[j];
				String queryrules = "insert into rulestbl VALUES('" + mainrule + "','" + rule + "','" + supportconverted + "','" + confconverted + "')";
			
				st3.executeUpdate(queryrules);

			}
			
			}
			
			
			results.clear();
			colindex1.clear();
			colindex2.clear();
			
			
        
	} //br.readline
	} //try
	
	
	catch (FileNotFoundException e) {
		
		e.printStackTrace();
	}
    
	catch (IOException e) {
		e.printStackTrace();
	} 
    
			} //else
				
			
				
		} //for loop 2
		
		
		
		
	}   //for loop 1
	try
	{
		//Connecting to the database
		Class.forName("com.mysql.jdbc.Driver");  
	    String url1="jdbc:mysql://127.0.0.1:3306/healthcare";
	    Connection connection1 = DriverManager.getConnection(url1, "root", "root");
	    Statement st0 = null;
		String finalresult = "select DISTINCT rule, rulename,support,confidence from rulestbl";
		st0 = connection1.createStatement();
		ResultSet finalset = st0.executeQuery(finalresult);
		int counter = 0;
		
		//Printing the rules
		while(finalset.next())
		{
			//counter = counter +1;
			out.println("<br>");
			out.println(" Main Rule: " + finalset.getString(2));
			out.println("<br>");
			out.println("Rule: " + finalset.getString(1));
			out.println("<br>");
			out.println("Support is: " + finalset.getString(3));
			out.println("<br>");
			out.println("Confidence is: " + finalset.getString(4));
			out.println("<br>");
		}
		
	}
	
	catch(Exception e)
	{
		
		
	}
	
    %>


	<FORM action="home.jsp">
		<input type="submit" value="Home Page" id="button-1">

	</FORM>

	</font>
</body>
</html>