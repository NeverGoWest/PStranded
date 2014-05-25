mob/

	text = "@"
	density = 0

	var/
		brute = 0 // brute damage to the body
		rads = 0 // radiation absorbed, if 100 the person gets cancer which will slowly kill the person with tox damage
		tox = 0 // toxin damage, from creature venom and cancer
		temp = 30 // body temperature, slows you if it goes below 30 and you dehydrate faster if over 30
		// toxin damage slowly increases untill it kills the creature, rads slowly leak into the environment.


		biomass = 100
		cancer = 0


		encumberment = 0
		movementmeth = "moves"
		driving = 0 // is this person driving a vehicle?
		sailing = 0 // is the person sailing?
		swimming = 0 // is the person swimming?
		hasrope = 0 // can climb a mountain? rope is consumed on use
		hasglider = 0 // is this person capable of crossing a canyon?
		flying = 0 // able to pass mountains?

		// resources
		wood = 0
		water = 100
		grass = 0
		rock = 0
		ore = 0
		chems = 0
		scrap = 0
		machineparts = 0
		electronics = 0
		food = 100
		energy = 0
		fertilizer = 0
		fuel = 0

		// the combat variables
		hitchance = 4
		armorbonus = 0
		weaponbonus = 0
		weapondamage = 1
		weaponmultiplier = 1
		weapon = "weapon"
		fistbonus = 0
		fistdamage = 1 // Damage when unarmed
		fistmultiplier = 1
		fist = "Fists"
		speed = 10


	proc/

		HitMe(dmg, bonus)
			var/damage
			if(roll("1d6")>= hitchance - bonus)
				//view() << "[name] was hit for [dmg - armorbonus] damage!"
				damage = ((dmg + (roll("1d6")*bonus))) - armorbonus
				HurtMe(1, damage)
			else
				view() << "[usr] misses [src]!"


		HurtMe(type, damage)
			if(type == 1)
				brute += damage
				view() << "[src] was hit for [damage] damage!"
				view() << "[src]'s health is now [src.brute]"
			if(type == 2)
				rads += damage
			if(type == 3)
				tox += damage
				view() << "[src] was poisoned!"
			if(brute >= 100)
				Die()
			if(tox >= 100)
				Die()
			if(rads >= 100)
				cancer = 1
			else
				if(brute <= 0)
					view() << "[usr] hugs [src] with affection!"
		Die()
			var/obj/Objekt
			var/obj/corpse/C = new/obj/corpse(loc)
			for(Objekt as obj in src)
				view() << "[src] drops [Objekt]"
				Objekt.loc = src.loc
			if(istype(loc,/turf))
				var/turf/T = loc
				T.wood += wood
				T.grass += grass
				T.rock += rock
				T.ore += ore
				T.scrap += scrap
				T.machineparts += machineparts
				T.electronics += electronics
				T.food += food
				T.energy += energy
				T.fertilizer += fertilizer
				T.chems += chems
				T.fuel += fuel
			//C.loc = loc
			//C = new/obj/corpse
			C.name = "Corpse of [name]"
			C.food = food
			C.biomass = biomass

			// create a ghost for the mob if it has a key
			if(key)
				var/mob/ghost/V = new/mob/ghost(loc)
				V.key = key

			view() << "[src] dies!"

			del src

	Stat()

		statpanel("Status", "Life:", 100 - brute)
		statpanel("Status", "Food:", food)
		statpanel("Status", "Water:", water)

		statpanel("Status", "Wielding: ", weapon)
		statpanel("Status", "Damage: ", weapondamage)
		statpanel("Status", "Bonus: ", weaponbonus)
		statpanel("Status", "Multiplier: ", weaponmultiplier)

		statpanel("Inventory", contents)
		statpanel("Resources", "Wood: ", wood)
		statpanel("Resources", "Water: ", water)
		statpanel("Resources", "Grass: ", grass)
		statpanel("Resources", "Rock: ", rock)
		statpanel("Resources", "Ore: ", ore)
		statpanel("Resources", "Scrap: ", scrap)
		statpanel("Resources", "Machine parts: ", machineparts)
		statpanel("Resources", "Electronic parts: ", electronics)
		statpanel("Resources", "Food: ", food)
		statpanel("Resources", "Fertilizer: ", fertilizer)
		statpanel("Resources", "Chemicals: ", chems)
		statpanel("Resources", "Fuel: ", fuel)


		/*
		statpanel(name)
		stat(src)
		statpanel("Inventory")
		stat(contents)*/
		//statpanel("Combat")
		//stat(Attack())

	/*Move()
		view(2, src) << "[src] aa [movementmeth] [dir]"
		world << "[src]"
		..()*/

	verb/
		Say(txt as text)
			set category = "Chat"
			usr << "You say ''[txt]''"
			oview(0) << "[usr] says ''[txt]''"
		WSay(txt as text)
			set category = "Chat"
			world << "[usr]: [txt]"

		Attack(var/mob/M in oview())
			set category = "Combat"
			set src in oview(0)
			M.HitMe(weapondamage, weaponbonus)
		Fight(var/mob/M in oview())
			set category = "Combat"
			set src in oview(0)
			while(M.brute < 100)
				sleep(speed)
				Attack(M)
		Wield(var/obj/O)
			weapondamage = O.weapondamage
			weaponbonus = O.weaponbonus
			weaponmultiplier = O.weaponmultiplier
			weapon = O.name
		Unwield()
			weapondamage = fistdamage
			weaponbonus = fistbonus
			weaponmultiplier = fistmultiplier
			weapon = fist

		OpenThirdEye()
			set category = "Debug"
			client.view = 3
		Isolate()
			set category = "Debug"
			client.view = 1

		TurnOffTheLights()
			set category = "Debug"
			for(var/turf/T in world)
				T.luminosity = 0

		Search()
			set category = "Action"
			var/obj/A
			var/mob/B
			var/found = 0
			var/foundppl = 0

			/*
			wood = 0
			grass = 10
			rock = 0
			ore = 0
			scrap = 0
			machineparts = 0
			electronics = 0
			food = 0*/

			usr << "You search.."



			for (A in src.loc)
				usr << "You find [A.name]"
				found += 1

			if(!A && !found)
				usr << "You dont find anything at all."

			for (B in src.loc)
				usr << "You see [B.name]"
				if (B.name == name)
					usr << "That's you!"
				foundppl += 1

		Survey()
			set category = "Action"
			if(istype(loc,/turf))
				var/turf/T = loc
				usr << "Wood: [T.wood]"
				usr << "Grass: [T.grass]"
				usr << "Rock: [T.rock]"
				usr << "Ore: [T.ore]"
				usr << "Scrap metal: [T.scrap]"
				usr << "Machine parts: [T.machineparts]"
				usr << "Electronic parts: [T.electronics]"
				usr << "Veggies: [T.food]"
				usr << "Fertilizer: [T.fertilizer]"
				usr << "Chems: [T.chems]"
				if(T.energy > 50)
					usr << "It is very sunny here."
				if(T.energy < 50)
					usr << "Clouds cover the sun, letting little light pass through"


		// movement commands
		East()
			set category = "Movement"
			view(0) << "[usr] [movementmeth] east."
			step(src, EAST)
			//usr.x = usr.x + 1
		West()
			set category = "Movement"
			view(0) << "[usr] [movementmeth] west."
			//usr.x = usr.x - 1
			step(src, WEST)
		North()
			set category = "Movement"
			view(0) << "[usr] [movementmeth] north."
			//usr.y = usr.y + 1
			step(src, NORTH)
		South()
			set category = "Movement"
			view(0) << "[usr] [movementmeth] south."
			//usr.y = usr.y - 1
			step(src, SOUTH)

		Assemble(thing as text)
			set category = "Action"
			if(thing == "car")
				if(scrap <= 0)
					usr << "You dont have any grass!"
					return
				scrap -= 10
				new/obj/car(loc)
				usr << "You assemble a car from scrap metal!"

		Extract(type as text)
			set category = "Action"
			if(type == "wood")
				if(istype(loc,/turf))
					var/turf/T = loc
					if(T.wood <= 0)
						usr << "There is no wood here!"
						return
					T.wood = T.wood - 10
					usr.wood = usr.wood + 10
					usr << "You chop some wood."
			if(type == "grass")
				if(istype(loc,/turf))
					var/turf/T = loc
					if(T.grass <= 0)
						usr << "There is no grass here!"
						return
					T.grass = T.grass - 10
					usr.grass = usr.grass + 10
					usr << "You pick some grass."
			if(type == "rock")
				if(istype(loc,/turf))
					var/turf/T = loc
					if(T.rock <= 0)
						usr << "There are no rocks here!"
						return
					T.rock = T.rock - 1
					usr.rock = usr.rock + 1
					usr << "You pick up a rock."
			if(type == "ore")
				if(istype(loc,/turf))
					var/turf/T = loc
					if(T.ore <= 0)
						usr << "There is no ore to be found here!"
						return
					T.ore = T.ore - 1
					usr.ore = usr.ore + 1
					usr << "You pick up some ore."
			if(type == "scrap")
				if(istype(loc,/turf))
					var/turf/T = loc
					if(T.scrap <= 0)
						usr << "There is no scrap to be salvaged."
						return
					T.scrap = T.scrap + 1
					usr.scrap = usr.scrap + 1
					usr << "You salvage a piece of scrap metal!"
			if(type == "part")
				if(istype(loc,/turf))
					var/turf/T = loc
					if(T.machineparts <= 0)
						usr << "There is no machine parts to be salvaged."
						return
					T.machineparts = T.machineparts - 1
					usr.machineparts = usr.machineparts + 1
					usr << "You pick up a machine part."
			if(type == "electronics")
				if(istype(loc,/turf))
					var/turf/T = loc
					if(T.electronics <= 0)
						usr << "There is no electronics to be salvaged"
						return
					T.electronics = T.electronics - 10
					usr.electronics = usr.electronics + 10
					usr << "You pick up some electronic parts!"
			if(type == "food")
				if(istype(loc,/turf))
					var/turf/T = loc
					if(T.food <= 0)
						usr << "You cant find any wild vegetables here."
						return
					T.food = T.food - 10
					usr.food = usr.food + 10
					usr << "You pick some wild vegetables"
			//else
			//	usr.Say("I dont know what [type] is!")

mob/test/
	text = "Z"

mob/ghost/
	name = "Ghost"
	text = ""
	invisibility = 1
	see_invisible = 1

/*
		wood = 0
		grass = 10
		rock = 0
		ore = 0
		scrap = 0
		machineparts = 0
		electronics = 0
		food = 0*/
mob/verb/Suicide()
	Die()

mob/verb/Refart(pass as text)
	if(pass == "trotsky")
		world.Reboot()