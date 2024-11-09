
/obj/structure/tyranid/resin_jelly_pod
	name = "Resin jelly pod"
	desc = "A large resin pod. Inside is a thick, viscous fluid that looks like it doesnt burn easily."
	icon = 'modular_imperium/master_files/icons/tyranid/resin_pod.dmi'
	icon_state = "resinpod"
	density = FALSE
	opacity = FALSE
	anchored = TRUE
	max_integrity = 250
	layer = RESIN_STRUCTURE_LAYER
	pixel_x = -16
	pixel_y = -16
	tyranid_structure_flags = IGNORE_WEED_REMOVAL

	hit_sound = SFX_ALIEN_RESIN_MOVE
	destroy_sound = SFX_ALIEN_RESIN_MOVE
	///How many actual jellies the pod has stored
	var/chargesleft = 0
	///Max amount of jellies the pod can hold
	var/maxcharges = 10
	///Every 5 times this number seconds we will create a jelly
	var/recharge_rate = 10
	///Countdown to the next time we generate a jelly
	var/nextjelly = 0

/obj/structure/tyranid/resin_jelly_pod/Initialize(mapload, _hivenumber)
	. = ..()
	add_overlay(image(icon, "resinpod_inside", layer + 0.01, dir))
	START_PROCESSING(SSslowprocess, src)

/obj/structure/tyranid/resin_jelly_pod/Destroy()
	STOP_PROCESSING(SSslowprocess, src)
	return ..()

/obj/structure/tyranid/resin_jelly_pod/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(istyranid(user))
		. += "It has [chargesleft] jelly globules remaining[datum_flags & DF_ISPROCESSING ? ", and will create a new jelly in [(recharge_rate-nextjelly)*5] seconds": " and seems latent"]."

/obj/structure/tyranid/resin_jelly_pod/process()
	if(nextjelly <= recharge_rate)
		nextjelly++
		return
	nextjelly = 0
	chargesleft++
	if(chargesleft >= maxcharges)
		return PROCESS_KILL

/obj/structure/tyranid/resin_jelly_pod/attack_alien(mob/living/carbon/tyranid/tyranid_attacker, damage_amount = tyranid_attacker.tyranid_caste.melee_damage, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = tyranid_attacker.tyranid_caste.melee_ap, isrightclick = FALSE)
	if(tyranid_attacker.status_flags & INCORPOREAL)
		return FALSE

	if((tyranid_attacker.a_intent == INTENT_HARM && istyranidhivelord(tyranid_attacker)) || tyranid_attacker.hivenumber != hivenumber)
		balloon_alert(tyranid_attacker, "Destroying...")
		if(do_after(tyranid_attacker, HIVELORD_TUNNEL_DISMANTLE_TIME, IGNORE_HELD_ITEM, src, BUSY_ICON_BUILD))
			deconstruct(FALSE)
		return

	if(!chargesleft)
		balloon_alert(tyranid_attacker, "No jelly remaining")
		to_chat(tyranid_attacker, span_tyranidnotice("We reach into \the [src], but only find dregs of resin. We should wait some more.") )
		return
	balloon_alert(tyranid_attacker, "Retrieved jelly")
	new /obj/item/resin_jelly(loc)
	chargesleft--
	if(!(datum_flags & DF_ISPROCESSING) && (chargesleft < maxcharges))
		START_PROCESSING(SSslowprocess, src)
