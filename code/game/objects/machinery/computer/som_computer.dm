/obj/machinery/computer/chaos
	name = "\improper CHAOS computer"
	desc = "A fancy touch screen computer terminal."
	density = TRUE
	icon_state = "chaos_computer"
	screen_overlay = "chaos_computer_emissive"
	light_color = LIGHT_COLOR_FLARE
	layer = ABOVE_MOB_LAYER

/obj/machinery/computer/chaos/Initialize(mapload)
	. = ..()
	if(dir == SOUTH || dir == NORTH)
		pixel_y = 10

/obj/machinery/computer/chaos/update_icon_state()
	. = ..()
	if(machine_stat & (BROKEN|DISABLED))
		icon_state = "[initial(icon_state)]_broken"
	else if(machine_stat & NOPOWER)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_on"

/obj/machinery/computer/chaos_two
	name = "\improper CHAOS console"
	desc = "A computer console of some description."
	density = TRUE
	icon_state = "chaos_console"
	screen_overlay = "chaos_console_screen"
	light_color = LIGHT_COLOR_FLARE
