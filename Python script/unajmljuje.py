import random

jmbg = ['2803912710935', '0909979715668', '0203931710435', '2209998715599', '1501992710624', '1009939715880', '0604932715687', '1010986710587', '1902924710727', '0607930715515', '1903926710200', '1204908715176', '2112991715811', '1201956710129', '0706975710356', '1407971715531', '3009989710326', '0909949715372', '1809931715788', '0310903715142', '0208956710116', '1801939715127', '1511940710536', '1806905710351', '1811988715623', '2706930715964', '3103950710596', '2710964715606', '0807904710514', '0907918715164', '0709976710562', '0906972715146', '2209975710953', '1006965710416', '1608926710818', '0609972710776', '1906917710742', '1610923710956', '2910978715648', '2204956710865', '1205965715986', '2508978715333', '2204955710200', '1704944715223', '1901987715126', '3111950715983', '1505926715109', '0204993715786', '0103996710750', '2102985710834', '1102964715575', '2201996715877', '1803957710403', '0211964715901', '0908956715172', '3104927715378', '0906963710570', '2810952710723', '0505996715518', '0401945715927', '2909983715463', '1602916710192', '0111917715639', '2910949710133', '0306915710267', '0703929710837', '0510921710644', '2408967715478', '2305977715688', '0809967710529', '2604983715708', '0404990710947', '1709935715976', '0210991715825', '0803957710382', '0802974710418', '1106967715855', '1012935715667', '3103931715782', '0102990710679', '1509935715370', '1510998715825', '0402981710643', '0103933715537', '1002945715691', '0107986710381', '2504931715433', '0201992710386', '2106917715774', '1307979715256', '2107979715774', '2707965710321', '1305928710478', '2101923710225', '2306940715220', '1406953715116', '1004989715407', '2103913715641', '0409986710746', '2801987715868', '2405971710240', '0112925710401', '2606948710995', '1208957710224', '3109929715972', '0301919710235', '0309982710214', '0207943715307', '1506984715908', '0307956710724', '0409902715351', '1201919710355', '0206979715594', '0108957715872', '2710993715552', '2602937710219', '1405963710170', '0501907715586', '1210925710164', '1910999710828', '1304957710179', '0308990715654', '2904958715489', '1612976715973', '1609919715687', '0812906710938', '0505979710694', '2911925710662', '0711922710796', '1810914715757', '2811988710985', '0301912710177', '2104962715338', '1102943710682', '0710991710146', '0311933715623', '0804948715741', '1910951710459', '2705949715222', '2804900710281', '3012924715579', '0412939710173', '2902981710241', '3103905710508', '2907978715887', '1902958715537', '1008904715772', '1711914710891', '1508958715170', '0704969715360', '0908933715262', '0903992710240', '0601938715879', '2312912715195', '0909973715727', '2311967710428', '3009989715367', '2712908710190', '0803993715514', '0802930710766', '1409923715578', '0811946715170', '0209908715620', '2703988710197', '2311951715610', '0807950715509', '1006920715727', '1405985710807', '0604925715447']
#honorar, model osoba jmbg, modna revija id 10

unajmljuje = dict()
for i in range(1,11):
	for j in range(random.randint(5, 30)):
		unajmljuje[(i, jmbg[0 + random.randint(26,55)])] = random.randint(100,1000)
	
for i in range(30):
	unajmljuje[(random.randint(1, 10), jmbg[26 + i])] = random.randint(100,1000)
		
		
print "INSERT INTO unajmljuje(Modna_revija_id, `Model_Osoba_jmbg`, Honorar) VALUES\n" + ",\n".join(map(lambda (x, y):"(" + str(x[0]) + ", '" + x[1] + "'," + str(y) + ")", unajmljuje.iteritems()))