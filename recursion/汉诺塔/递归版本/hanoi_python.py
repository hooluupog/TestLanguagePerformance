import datetime
count = 0
def hanoi(n,x,y,z):
    global count
    if(n == 1):
        count = count + 1
    else:
        hanoi(n-1,x,z,y)
        count = count + 1
        hanoi(n-1,y,x,z)
if __name__ == "__main__":
    start = datetime.datetime.now()
    hanoi(25,'A','B','C')
    duration = datetime.datetime.now() - start
    print ("%f%s" %(duration.total_seconds()*1000,"ms"))
