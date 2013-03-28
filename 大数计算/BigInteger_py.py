import datetime
import sys
if __name__ == "__main__":
	start = datetime.datetime.now()
	a = int(sys.stdin.readline())
	b = int(sys.stdin.readline())
	c = a*b
	duration = datetime.datetime.now() - start
	print "%d\n%f%s" %(c,duration.total_seconds()*1000,"ms")
