import serial
import time
import os
import xmlformatter

#opening the serial port
ser = serial.Serial('/dev/ttyACM0', 115200, timeout=1) 
f1 = open('test-results.xml', 'w+')
f2 = open('test.log','w+')

start_tag = NULL
end_tag = NULL
testcases = []
testsuite = []

while True:
	data = ser.readline().decode('ascii')
	if(data[0:1] == "<"):
		f1.write(data)
	print (data.rstrip("\r\n"))
	f2.write(data)
	if(data == '</test-run>'):
		break

f1.close()
f2.close()

#moving the test cases after test-suite
testcount = 3
for i in range(0,testcount):
	os.system("printf '%s\n' '1m6' 'wq' | ed -s test-results.xml")

#Formatting the xml output
formatter = xmlformatter.Formatter(indent="1", indent_char="\t", encoding_output="UTF-8", preserve=["literal"])
xmldata = formatter.format_file("test-results.xml") 
f3 = open('test-results.xml', 'wb+')
f3.write(xmldata)
f3.close()
ser.close()
exit()
