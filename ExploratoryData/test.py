import re
fh = open('/Users/Sean/Desktop/regex_sum_274832.txt')
text = fh.read()
print (text)
number = 0
num =  re.findall('[0-9]+',text)
for i in num:
    i = int(i)
    number = number + i

print (number )


