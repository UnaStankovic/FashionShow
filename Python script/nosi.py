import random

parovi = [[8, '0907918715164'], [4, '0609972710776'], [7, '1102964715575'], [8, '0103996710750'], [4, '1901987715126'], [7, '1608926710818'], [9, '3103950710596'], [3, '0807904710514'], [7, '1906917710742'], [2, '0103996710750'], [5, '1901987715126'], [8, '1006965710416'], [10, '3104927715378'], [10, '1610923710956'], [2, '1610923710956'], [5, '1006965710416'], [7, '0709976710562'], [5, '0907918715164'], [8, '1901987715126'], [3, '2201996715877'], [5, '2910978715648'], [3, '1906917710742'], [2, '0908956715172'], [4, '2710964715606'], [6, '2201996715877'], [1, '1704944715223'], [1, '1906917710742'], [6, '1505926715109'], [4, '1006965710416'], [1, '2209975710953'], [4, '3111950715983'], [3, '1102964715575'], [1, '1102964715575'], [4, '2102985710834'], [10, '1704944715223'], [10, '2508978715333'], [3, '1608926710818'], [5, '1610923710956'], [9, '0204993715786'], [3, '2710964715606'], [9, '0907918715164'], [10, '1205965715986'], [7, '1803957710403'], [2, '0211964715901'], [3, '3111950715983'], [1, '2102985710834'], [7, '0906972715146'], [1, '0906972715146'], [1, '1006965710416'], [6, '2204956710865'], [4, '1906917710742'], [4, '1205965715986'], [7, '0211964715901'], [10, '0908956715172'], [7, '2102985710834'], [5, '2204955710200'], [6, '0908956715172'], [1, '2710964715606'], [4, '3104927715378'], [10, '3103950710596'], [2, '2910978715648'], [10, '1803957710403'], [2, '2508978715333'], [5, '0103996710750'], [3, '1610923710956'], [5, '0906972715146'], [8, '1608926710818'], [3, '0709976710562'], [6, '3111950715983'], [5, '3111950715983'], [7, '2204955710200'], [5, '0609972710776'], [8, '3104927715378'], [6, '0807904710514'], [8, '3103950710596'], [6, '1608926710818'], [2, '0709976710562'], [9, '2201996715877'], [5, '2102985710834'], [7, '0609972710776'], [3, '1006965710416'], [6, '1610923710956'], [3, '2508978715333'], [3, '2102985710834'], [3, '2209975710953'], [3, '2910978715648'], [1, '2910978715648'], [9, '0807904710514'], [7, '2710964715606'], [1, '3104927715378'], [9, '1704944715223'], [4, '2508978715333'], [9, '0609972710776'], [8, '1505926715109'], [3, '0907918715164'], [6, '0211964715901'], [1, '1608926710818'], [3, '2204956710865'], [5, '2201996715877'], [4, '0906972715146'], [1, '1803957710403'], [8, '0211964715901'], [2, '3111950715983'], [7, '1505926715109'], [5, '2710964715606'], [6, '2710964715606'], [6, '2204955710200'], [1, '0709976710562'], [10, '2209975710953'], [6, '1205965715986'], [2, '1608926710818'], [1, '2201996715877'], [1, '2204956710865'], [2, '0609972710776'], [7, '2209975710953'], [3, '0204993715786'], [10, '1901987715126'], [5, '0211964715901'], [8, '0908956715172'], [7, '1205965715986'], [3, '1505926715109'], [8, '0709976710562'], [2, '0807904710514'], [7, '1006965710416'], [7, '2204956710865'], [10, '0609972710776'], [6, '1704944715223'], [5, '1102964715575'], [2, '0906972715146'], [3, '1704944715223'], [5, '1803957710403'], [3, '1205965715986'], [1, '1505926715109'], [7, '2201996715877'], [4, '0908956715172'], [7, '0807904710514'], [8, '2910978715648'], [4, '0204993715786'], [10, '0103996710750'], [4, '1803957710403'], [5, '2508978715333'], [1, '0103996710750'], [10, '0709976710562'], [7, '0908956715172'], [6, '1102964715575'], [1, '2204955710200'], [1, '1610923710956'], [7, '0204993715786'], [10, '0807904710514'], [7, '2910978715648'], [9, '3104927715378'], [7, '3104927715378'], [10, '0907918715164'], [2, '2209975710953'], [2, '2102985710834'], [6, '2910978715648'], [5, '1704944715223'], [10, '1608926710818'], [6, '2508978715333']]

#unajmljuje modna revija id, unajmljuje model osoba jmbg, haljina id 99


nosi = dict()
for i in range(0,159):
	for j in range(random.randint(2,6)):
		nosi[(tuple(parovi[i]), random.randint(1,99))] = ''
	
for i in range(1,100):
	nosi[(tuple(parovi[random.randint(0,158)]), i)] = ''
		
		
print "INSERT INTO nosi(Unajmljuje_Modna_revija_id, `Unajmljuje_Model_Osoba_jmbg`, Haljina_id) VALUES\n" + ",\n".join(map(lambda x:"(" + str(x[0][0]) + ", '" + x[0][1] + "'," + str(x[1]) + ")", nosi.keys()))

