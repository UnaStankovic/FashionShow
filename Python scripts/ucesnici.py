import random

def dopuni(br, duz):
	return (duz - len(br)) * "0" + br

imena = ['Ana', 'Ivana', 'Petar', 'Filip', 'Marko', 'Marija', 'Sara', 'Jovana', 'Sofija', 'Stefan', 'Aleksandar', 'Andrija', 'Ivanka', 'Dragana', 'Slavica']
prezimena = ['Andric', 'Petrovic', 'Slavkovic', 'Ivanic', 'Stankovic', 'Ognjenovic', 'Dragosevic', 'Saric', 'Petrovic', 'Mirkovic', 'Leptiric', 'Cvetic', 'Srcic']
adrese = ['Pariske komune', 'General Zdanova', 'Milesevska', 'Save Kovacevica', 'Galilejeva', 'Brace Jugovic', 'Simina', 'Jurija Gagarina', 'Vatroslava Jagica','Sumarska', 'Takovska', 'Vojvode Stepe', 'Bulevar kralja Aleksandra']

ucesnici = list()
for i in range(69):
	br1 = str(random.randint(1, 31))
	br2 = str(random.randint(1, 12))
	ucesnici.append([dopuni(br1, 2) + dopuni(br2, 2) + str(random.randint(900, 999)) + random.choice(['715', '710']) + str(random.randint(100, 999)),
					random.choice(imena), 
					random.choice(prezimena), 
					random.choice(adrese) + ' ' + str(random.randint(1, 200)), 
					'011' + dopuni(str(random.randint(0, 999999)), 6)])
	
print "INSERT INTO ucesnici(jmbg, ime, prezime, adresa, telefon) VALUES\n" + ",\n".join(map(lambda x: "(" + ", ".join(["'" + x[0] + "'", "'" + x[1] + "'", "'" + x[2] + "'", "'" + x[3] + "'", "'" + x[4] + "'"]) + ")", ucesnici))