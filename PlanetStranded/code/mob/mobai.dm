var/shapelist[] = list("humanoid shape", "beastly shape", "a wobbly blob shape", "polyp shape", "starfish shaped body", "a scaly body", "a hidy body", "an exoskeleton")

mob/Creature/
	name = "Creature"

/*
	human = 1
	arms = 2
	legs = 2
	heads = 1
	tails = 0
	shape = 1
	description = "Creeping along the landscape, a feeble survivor of a spaceship crash, scavenging the land, salvaging the wreckage."
*/
	New()
		..()
		Generate()


	proc/
		Generate(pitspawn)
			var/namestring = "Critter"
			namestring = pick("Humbling ", "Animated ", "Slimy ") + pick("Dash", "Wrath", "Amoeba")
			text = pick("!", "@", "#", "h", "k", "c", "d", "d", "D")
			name = namestring
			human = 0
			arms = rand(0, 4)
			legs = rand(0, 4)
			heads = rand(1,2)
			tails = rand(1,2)
			shape = rand(1, 8)
			description  = pick("A small critter that scuttles across the ground with a fast pace.", "A dog sized muscular creature that leaps around like a dog would.", "A large, bulky hooved animal that slowly walks around, charging violently when aggravated.")
			view(0) << "[name] takes shape as [description]"
