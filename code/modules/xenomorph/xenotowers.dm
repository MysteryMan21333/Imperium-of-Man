
/obj/structure/tyranid/evotower
	name = "evolution tower"
	desc = "A sickly outcrop from the ground. It seems to ooze a strange chemical that shimmers and warps the ground around it."
	icon = 'modular_imperium/master_files/icons/tyranid/2x2building.dmi'
	icon_state = "evotower"
	bound_width = 64
	bound_height = 64
	obj_integrity = 600
	max_integrity = 600
	tyranid_structure_flags = CRITICAL_STRUCTURE|IGNORE_WEED_REMOVAL
	///boost amt to be added per tower per cycle
	var/boost_amount = 0.2
	///maturity boost amt to be added per tower per cycle
	var/maturty_boost_amount = 0.4

/obj/structure/tyranid/evotower/Initialize(mapload, _hivenumber)
	. = ..()
	GLOB.hive_datums[hivenumber].evotowers += src
	set_light(2, 2, LIGHT_COLOR_GREEN)

/obj/structure/tyranid/evotower/Destroy()
	GLOB.hive_datums[hivenumber].evotowers -= src
	return ..()

/obj/structure/tyranid/evotower/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			take_damage(700, BRUTE, BOMB)
		if(EXPLODE_HEAVY)
			take_damage(500, BRUTE, BOMB)
		if(EXPLODE_LIGHT)
			take_damage(300, BRUTE, BOMB)
		if(EXPLODE_WEAK)
			take_damage(100, BRUTE, BOMB)

/obj/structure/tyranid/psychictower
	name = "Psychic Relay"
	desc = "A sickly outcrop from the ground. It seems to allow for more advanced growth of the Tyranids."
	icon = 'modular_imperium/master_files/icons/tyranid/2x2building.dmi'
	icon_state = "maturitytower"
	bound_width = 64
	bound_height = 64
	obj_integrity = 400
	max_integrity = 400
	tyranid_structure_flags = CRITICAL_STRUCTURE|IGNORE_WEED_REMOVAL

/obj/structure/tyranid/psychictower/Initialize(mapload, _hivenumber)
	. = ..()
	GLOB.hive_datums[hivenumber].psychictowers += src
	set_light(2, 2, LIGHT_COLOR_GREEN)

/obj/structure/tyranid/psychictower/Destroy()
	GLOB.hive_datums[hivenumber].psychictowers -= src
	return ..()

/obj/structure/tyranid/psychictower/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			take_damage(700, BRUTE, BOMB)
		if(EXPLODE_HEAVY)
			take_damage(500, BRUTE, BOMB)
		if(EXPLODE_LIGHT)
			take_damage(300, BRUTE, BOMB)
		if(EXPLODE_WEAK)
			take_damage(100, BRUTE, BOMB)
