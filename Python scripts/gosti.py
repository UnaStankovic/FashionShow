import random

def dopuni(br, duz):
	return (duz - len(br)) * "0" + br

imena = ['Ana', 'Ivana', 'Petar', 'Filip', 'Marko', 'Marija', 'Sara', 'Jovana', 'Sofija', 'Stefan', 'Aleksandar', 'Andrija', 'Ivanka', 'Dragana', 'Slavica']
prezimena = ['Andric', 'Petrovic', 'Slavkovic', 'Ivanic', 'Stankovic', 'Ognjenovic', 'Dragosevic', 'Saric', 'Petrovic', 'Mirkovic', 'Leptiric', 'Cvetic', 'Srcic']

ucesnici = list()
for i in range(150):
	br1 = str(random.randint(1, 31))
	br2 = str(random.randint(1, 12))
	ucesnici.append([dopuni(br1, 2) + dopuni(br2, 2) + str(random.randint(900, 999)) + random.choice(['715', '710']) + str(random.randint(100, 999)),
					random.choice(imena), 
					random.choice(prezimena)])
	
print "INSERT INTO gost(jmbg, ime, prezime) VALUES\n" + ",\n".join(map(lambda x: "(" + ", ".join(["'" + x[0] + "'", "'" + x[1] + "'", "'" + x[2] + "'"]) + ")", ucesnici))