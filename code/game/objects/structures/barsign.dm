/obj/structure/sign/double/barsign
	icon = 'modular_imperium/master_files/icons/obj/structures/barsigns.dmi'
	icon_state = "off"

/obj/structure/sign/double/barsign/carp
	name = "The Drunk Carp"
	desc = "The Drunk Carp, Bar and Grill"
	icon_state = "thedrunkcarp"

/obj/structure/sign/double/barsign/Initialize(mapload)
	. = ..()
	icon = 'modular_imperium/master_files/icons/obj/structures/barsigns.dmi'
