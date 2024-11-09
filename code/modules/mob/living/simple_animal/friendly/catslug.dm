//No relation to slugcat

/mob/living/simple_animal/catslug
	name = "catslug"
	desc = "It's a cat . . . Thing from another planet, maybe from another world. You think it's not dangerous, but you can't be sure. The researcher should know more about this creature."
	icon = 'modular_imperium/master_files/icons/mob/pets.dmi'
	icon_state = "catslug"
	icon_living = "catslug"
	icon_dead = "catslug_dead"
	gender = MALE
	emote_see = list("stares at the ceiling.", "shivers.", "looks at the guardsmans.", "looks at the research paper.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	pass_flags = PASS_LOW_STRUCTURE
	response_help = "hugs"
	response_disarm = "rudely paps"
	response_harm = "kicks"

/mob/living/simple_animal/catslug/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/companion)

/mob/living/simple_animal/catslug/newt
	name = "Newt"
	real_name = "Newt"
	desc = "You recalled in another PowerPoint presentation that military loves to use that Newt is a survivor from the current Tyranid menace. Researchers found this poor thing amidst its kins, possibly gutted by tyranids. Who knows if Newt is the last of her kind."
	icon_state = "catslug"
	icon_living = "catslug"
	icon_dead = "catslug_dead"
	gender = FEMALE
