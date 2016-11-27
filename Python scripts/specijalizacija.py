import random
jmbg = ['0601927715854', '1611980715207', '2903919710443', '2308984715836', '1507947715327', '3005978710755', '0111931715638', '0612925715311', '1204941715813', '2903975710139', '0706968715818', '1604908715920', '2308950710152', '0509935710696', '1805983715421', '0503983715204', '2809916715351', '1401942715848', '3107943715671', '2708914710627', '1611922715230', '1606910715638', '2308923715709', '1808942715529', '1503947710593', '1303966715707', '2012924715278', '1808992710221', '1608977715969', '1805951710162', '2508964710683', '2410972715158', '0808915715166', '2010982715771', '0208914715279', '2203978715859', '0206914710264', '2604934710191', '3003952710758', '0202960710197', '1607908715680', '3109949715793', '1510953715727', '0105945710715', '2411955715982', '3102967710358', '2203946715826', '2305938715308', '2010979715185', '1002967715139', '0607918710791', '1301997710247', '1006956715726', '1104936710244', '0704913715597', '2308997715147', '2505932710953', '1403920710128', '1808960710833', '2406961715575', '3005997715302', '1407997715801', '1007919715519', '0605907710412', '0310979710522', '2904998715367', '1803986710602', '0807945710794', '1101990710383']

#dizajner pib naziv firme adresa ateljea 

naziv = [['Blah', 19102], ['Kompanija',18212], ['Fabrika',38293], ['Industrija',37373], ['Sofi',39232], ['Petra',29291], ['AF',3123], ['KM',3292], ['ITD',65545], ['LTD',54432], ['BELINC',20302], ['BG SHPR',42342],['Amolusso', 20111]]

adrese = ['Pariske komune', 'General Zdanova', 'Milesevska', 'Save Kovacevica', 'Galilejeva', 'Brace Jugovic', 'Simina', 'Jurija Gagarina', 'Vatroslava Jagica','Sumarska', 'Takovska', 'Vojvode Stepe', 'Bulevar kralja Aleksandra']
#dizajneri - [56-68], model - [26-55], pom osoblje - [0, 25]
dizajneri = list()
for i in range(13):
	dizajneri.append([jmbg[56 + i], naziv[i][1], naziv[i][0], adrese[i] + " " + str(random.randint(1,200))])

print "INSERT INTO dizajner(Ucesnici_jmbg, pib, `naziv firme`, `adresa ateljea`) VALUES\n" + ",\n".join(map(lambda x : '(' + ", ".join(["'" + x[0] + "'", str(x[1]), "'" + x[2] + "'","'" + x[3] + "'" ]) + ")", dizajneri)) + ";"
#model bmi tezina obim visina

modeli = list()
for i in range(30):
	modeli.append([jmbg[26+i] ,random.uniform(17,22), random.uniform(45,65), random.uniform(40,70), random.uniform(165,190)])

print "INSERT INTO model (Ucesnici_jmbg, bmi, tezina, obim, visina) VALUES\n" + ",\n".join(map(lambda x : '(' + ", ".join(["'"+ x[0] + "'", "ROUND("+ str(x[1]) +", 2)", "ROUND("+ str(x[2]) +", 2)", "ROUND("+ str(x[3]) +", 2)", "ROUND("+ str(x[4]) +", 2)"]) +')', modeli)) + ";"


#pomocno osoblje samo jmbg


print "INSERT INTO `pomocno osoblje` (Ucesnici_jmbg) VALUES\n" + ",\n".join(map(lambda x: '(' + "'" + x + "'" + ')', jmbg[0:26])) + ";"


