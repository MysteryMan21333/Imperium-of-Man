/obj/structure/lazarus_sign
	name = "Lazarus Landing Sign"
	desc = "A large sign reading 'lazarus landing por-' the rest of it is smeared in blood."
	icon = 'modular_imperium/master_files/icons/obj/landing_signs.dmi'
	icon_state = "laz_sign"
	bound_width = 64
	bound_height = 64
	density = TRUE
	coverage = 15

/obj/structure/solaris_sign
	name = "Solaris Ridge Sign"
	desc = "A large sign that reads 'Solaris Ridge -', the rest of it is scraped away."
	icon = 'modular_imperium/master_files/icons/obj/landing_signs.dmi'
	icon_state = "red_sign"
	bound_width = 64
	bound_height = 64
	density = TRUE

/obj/structure/kutjevo_sign
	name = "Kutjevo Sign"
	desc = "A large sign that reads 'Kutjevo pop-', the rest of it is obscured by claw marks."
	icon = 'modular_imperium/master_files/icons/obj/landing_signs.dmi'
	icon_state = "kut_sign"
	bound_width = 64
	bound_height = 32
	density = TRUE

/obj/structure/kutjevo_sign/Initialize(mapload)
	. = ..()
	icon_state = "kut_ingame"
	overlays += image(icon, src, "kut_sign_top", layer = ABOVE_ALL_MOB_LAYER, pixel_y = 32)

/obj/structure/prison_sign
	name = "UA Prison Docking Sign"
	desc = "A large sign that reads 'UA Prison Docking -', the rest of it is obscured by claw marks."
	icon = 'modular_imperium/master_files/icons/obj/landing_signs.dmi'
	icon_state = "prison_sign"
	bound_width = 64
	bound_height = 64

/obj/structure/ice_sign
	name = "Shiva's Ice Landing Sign"
	desc = "A large sign that reads 'Shiva's Ice L-nding -', bullet holes and torn metal obscuring the rest.'"
	icon = 'modular_imperium/master_files/icons/obj/landing_signs.dmi'
	icon_state = "ice_sign"
	bound_width = 64
	bound_height = 64

/obj/structure/dam_sign
	name = "Chigusa landing sign"
	desc = "A large sign that reads 'Chigusa mining colony', with half the sign written in japanese.."
	icon = 'modular_imperium/master_files/icons/obj/landing_signs.dmi'
	icon_state = "dam_sign"
	bound_width = 64
	density = TRUE
	coverage = 15

/obj/structure/dam_sign/damaged
	desc = "A large sign that reads 'Chigusa mining col-', with the rest being obscured by what looks to be tried blood, and damage."
	icon_state = "dam_sign"

/obj/structure/tachi_sign
	name = "Tachi Base sign"
	desc = "A large sign that reads 'Tachi Base located at the planet of Ceres V' with a flag of the Sons of Mars."
	icon = 'modular_imperium/master_files/icons/obj/landing_signs.dmi'
	icon_state = "tachi_sign"
	bound_width = 64
	density = TRUE
	coverage = 15

/obj/structure/roci_sign
	name = "Rocinante Base sign"
	desc = "A large sign that reads 'Rocinante Base' with a flag of the Sons of Mars."
	icon = 'modular_imperium/master_files/icons/obj/landing_signs.dmi'
	icon_state = "roci_sign"
	bound_width = 64
	density = TRUE
	coverage = 15
