obj/
	var/
		// resources
		wood = 0
		grass = 0
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
		biomass = 0

		material = "nothing"
		description = "Nothingness."
		heavy = 0

		weapondamage = 1
		weaponbonus = 0
		weaponmultiplier = 1
		wielded = 0


	verb/
		PickUp()
			if(!heavy && usr.encumberment <= 10)
				set src in oview(0)
				src.Move(usr)
				usr << "You pick up the [src]"
		Drop()
			set src in usr.contents
			if(wielded)
				usr.Unwield()
				wielded = 0

			loc = usr.loc
			view(0) << "[usr] drops the [name]"

obj/car/
	name = "Car"
	text = "C"
obj/corpse/
	name = "Corpse"
	text = "g" // lets hope its invisible to everyone else
	food = 10
	verb/Eat()
		usr.food += food
		world << "[usr] eats the [name]"
		del src
obj/axe/
	name = "Axe"
	text = ""
	weapondamage = 50
	weaponmultiplier = 2
	weaponbonus = 1
