import serial
import time
import os
import xmlformatter
import signal

def handler(signum, frame):
	print("Forever is over!")
	raise Exception("end of time")

def xml_formatter(xml_filename):
	#Formatting the xml output
	formatter = xmlformatter.Formatter(indent="1", indent_char="\t", encoding_output="UTF-8", preserve=["literal"])
	xmldata = formatter.format_file(xml_filename) 
	f3 = open(xml_filename, 'wb+')
	f3.write(xmldata)
	f3.close()
	
def main():

	
	#Variables
	start_tag = ""
	end_tag = ""
	testcases = []
	testsuite_st_tag = ""
	testsuite_ed_tag = ""
	testrun = ""
	testcount = 0
	
	#initialising timeout of 10 secs
	signal.signal(signal.SIGALRM, handler)
	signal.alarm(10)
	print ("timeout starts.......")
	
	#opening the serial port
	ser = serial.Serial('/dev/ttyACM0', 115200, timeout=1) 
	f1 = open('test-results.xml', 'w+')
	f2 = open('test.log','w+')

	while True:
		data = ser.readline().decode('ascii')
		if (data):
			signal.alarm(10)
			print ("timeout reset.......")
			print (data.rstrip("\r\n"))
			f2.write(data)
			if(data[0:10] == "<test-case"):
				testcases.append(data)
				testcount = testcount + 1
			elif(data[0:5] == "<?xml"):
				start_tag = data
			elif(data[0:9] == "<test-run"):
				testrun = data
			elif(data[0:11] == "<test-suite"):
				testsuite_st_tag = data
			elif(data[0:13] == '</test-suite>'):
				testsuite_ed_tag = data
			if(data == '</test-run>'):
				end_tag = data
				break
		else:
			print ("waiting for input on serial port.......")

	#writing to the test-results.xml file in xml format
	f1.write(start_tag)
	f1.write(testrun)
	f1.write(testsuite_st_tag)
	for i in range(0,testcount):
		f1.write(testcases[i])
	f1.write(testsuite_ed_tag)
	f1.write(end_tag)


	f1.close()
	f2.close()
	
	xml_formatter('test-results.xml')

	ser.close()
	exit()


if __name__ == "__main__":
    main()
