import random

sezona = ['Jesen/Zima', 'Prolece/Leto']
naziv = ['Nova', 'Trougao', 'Paris', 'Alcanzar', 'Estrella', 'Aceituna', 'Love', 'Smile', 'Fun', 'Youth']
tip = ['Haute couture', 'Lingerie', 'Cocktail time', 'Everyday', 'Casual', 'Bridal']

kolekcije = list()
for i in range(30):
	kolekcije.append([random.choice(sezona), str(random.randint(2006,2016)),random.choice(naziv), random.choice(tip)])

#print kolekcije	
print "INSERT INTO Kolekcija (sezona, godina, naziv, tip) VALUES\n" + ",\n".join(map(lambda x: "(" + ", ".join(["'" + x[0] + "'", x[1], "'" + x[2] + "'", "'" + x[3] + "'"]) + ")", kolekcije))
