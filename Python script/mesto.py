import random

adrese = ['Pariske komune', 'General Zdanova', 'Milesevska', 'Save Kovacevica', 'Galilejeva', 'Brace Jugovic', 'Simina', 'Jurija Gagarina', 'Vatroslava Jagica','Sumarska', 'Takovska', 'Vojvode Stepe', 'Bulevar kralja Aleksandra']
gradovi = ['Beograd', 'Novi Sad', 'Cacak', 'Kraljevo', 'Krusevac', 'Subotica', 'Sabac']
ptt = ['11000', '21000', '32000', '36000', '37000', '24000', '15000']

mesta = list()
for i in range(0, len(gradovi)):
	mesta.append([gradovi[i], ptt[i], adrese[i] + " " + str(random.randint(1, 150))])
	
print "INSERT INTO `Mesto_odrzavanja`(naziv, ptt, adresa) VALUES\n" + ",\n".join(map(lambda x: "(" + ", ".join(["'" + x[0] + "'",  x[1] , "'" + x[2] + "'"]) + ")", mesta))