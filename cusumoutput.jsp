<%@page import="java.lang.*" import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.File"%>


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
		src="images/GenesisTheBirth-Logo.png" height="100" width="300" /> <%

float[] A = new float[20];
float[] B=new float[20];
float[] C=new float[20];
float[] D=new float[20];
int z=0;


//Getting the temporal dataset values
String value1 = request.getParameter("value1");
A[0] = Float.parseFloat(value1);

String value2 = request.getParameter("value2");
A[1] = Float.parseFloat(value2);

String value3 = request.getParameter("value3");
A[2] = Float.parseFloat(value3);

String value4 = request.getParameter("value4");
A[3] = Float.parseFloat(value4);

String value5 = request.getParameter("value5");
A[4] = Float.parseFloat(value5);

String value6 = request.getParameter("value6");
A[5] = Float.parseFloat(value6);

String value7 = request.getParameter("value7");
A[6] = Float.parseFloat(value7);

String value8 = request.getParameter("value8");
A[7] = Float.parseFloat(value8);

String value9 = request.getParameter("value9");
A[8] = Float.parseFloat(value9);

String value10 = request.getParameter("value10");
A[9] = Float.parseFloat(value10);

String value11 = request.getParameter("value11");
A[10] = Float.parseFloat(value11);

String value12 = request.getParameter("value12");
A[11] = Float.parseFloat(value12);

String value13 = request.getParameter("value13");
A[12] = Float.parseFloat(value13);

String value14 = request.getParameter("value14");
A[13] = Float.parseFloat(value14);

String value15 = request.getParameter("value15");
A[14] = Float.parseFloat(value15);

String value16 = request.getParameter("value16");
A[15] = Float.parseFloat(value16);

String value17 = request.getParameter("value17");
A[16] = Float.parseFloat(value17);

String value18 = request.getParameter("value18");
A[17] = Float.parseFloat(value18);

String value19 = request.getParameter("value19");
A[18] = Float.parseFloat(value19);

String value20 = request.getParameter("value20");
A[19] = Float.parseFloat(value20);


//Getting the SD, mean and sigma
float mean = Float.parseFloat(request.getParameter("mean"));
float deviation = Float.parseFloat(request.getParameter("deviation"));
float sigma = Float.parseFloat(request.getParameter("sigma"));

float threshold = deviation * sigma;


for(int i=0;i<A.length;i++) // mean - input
{
    B[i] =A[i]-mean ;

}
    C[0]=B[0];
for(int j=1;j<B.length;j++) // cumulative sum
{  
    C[j]=B[j]+C[j-1];
   // writer.write(Float.toString(C[j]));
  
}

out.println("<br>");
out.println("<br>");
out.println("The cumulative sum is");
out.println("<br>");
for(int k=0;k<C.length;k++)
{
	
out.println(C[k]);
out.println("<br>");
}


out.println("The data points above the threshold are:");
for(int l=0;l<C.length;l++)
{
	if(C[l] > threshold)
	{
		D[z] = A[l];
		out.println(A[l]);
		z = z+1;
	}
	
}
out.println("<br>");
out.println("The data points below the threshold are:");
for(int l=0;l<C.length;l++)
{
	if(C[l] < -threshold)
	{
		out.println(A[l]);
	}
	
}

//Storing the results in the csv file
String COMMA_DELIMITER = ",";
String NEW_LINE_SEPARATOR = "\n";
String FILE_HEADER = "Number,Data Point, Mean,Difference, Cumulative Sum";
FileWriter fileWriter = null;
fileWriter = new FileWriter("/Users/sumanthpikkili/Desktop/cusum_output.csv");
fileWriter.append(FILE_HEADER.toString());
fileWriter.append(NEW_LINE_SEPARATOR);


for(int m=1;m<A.length+1;m++)
{
	fileWriter.append(Integer.toString(m));
	fileWriter.append(COMMA_DELIMITER);
	fileWriter.append(Float.toString(A[m-1]));
	fileWriter.append(COMMA_DELIMITER);
	fileWriter.append(Float.toString(mean));
	fileWriter.append(COMMA_DELIMITER);
	fileWriter.append(Float.toString((B[m-1])));
	fileWriter.append(COMMA_DELIMITER);
	fileWriter.append(Float.toString(C[m-1]));
	 fileWriter.append(NEW_LINE_SEPARATOR);
		
}

fileWriter.append(NEW_LINE_SEPARATOR);
fileWriter.append(NEW_LINE_SEPARATOR);
fileWriter.append("Mean");
fileWriter.append(COMMA_DELIMITER);
fileWriter.append(Float.toString(mean));
fileWriter.append(NEW_LINE_SEPARATOR);
fileWriter.append("Standard Deviation");
fileWriter.append(COMMA_DELIMITER);
fileWriter.append(Float.toString(deviation));
fileWriter.append(NEW_LINE_SEPARATOR);
fileWriter.append("Sigma");
fileWriter.append(COMMA_DELIMITER);
fileWriter.append(Float.toString(sigma));
fileWriter.append(NEW_LINE_SEPARATOR);
fileWriter.append("Data Points Above Threshold");
fileWriter.append(COMMA_DELIMITER);

for(z=0;z<D.length;z++)
{
	
	fileWriter.append(Float.toString(D[z]));
	fileWriter.append(COMMA_DELIMITER);
}

fileWriter.append(NEW_LINE_SEPARATOR);

System.out.println("CSV file was created successfully !!!");
fileWriter.close();

%>
</body>
</html>