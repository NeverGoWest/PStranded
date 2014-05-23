obj/
	var/
		// resources
		wood = 0
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
		biomass = 0

		material = "nothing"
		description = "Nothingness."
		heavy = 0


	verb/
		PickUp()
			if(!heavy && usr.encumberment <= 10)
				set src in oview(0)
				src.Move(usr)
				usr << "You pick up the [src]"
		Drop()
			set src in usr.contents
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
