turf/
	text = "<font color=#52F53C bgcolor=#40C92E>."
	luminosity = 1
	var/description = "A barren wasteland."

	verb/Look()
		usr << description


	var/
		wood = 0
		water = 0
		grass = 10
		rock = 0
		ore = 0
		scrap = 0
		machineparts = 0
		electronics = 0
		food = 0
		energy = 0
		fertilizer = 0
		chems = 0
		fuel = 0

		biomass = 0 // stored biomass, if this becomes 100 it will turn the turf into a biomatter mound that will grow and kill/poison everything in its path. Pit Spawn eats this (too). Plants take it up like fertilizer


		// environment conditions
		safe = 0 // safe from elements? This is for houses and caves.
		tbonus = 1 // The divider/multiplier of the players speed, its fast to move along a road, slow to creep around in a forest.

turf/forest/
	name = "Forest"
	text = "<font color=#40C92E bgcolor=#33A125>F"
	tbonus = 0.5

turf/road/
	name = "Road"
	text = "<font color=#F2E11F bgcolor=#454545>."
	tbonus = 2



