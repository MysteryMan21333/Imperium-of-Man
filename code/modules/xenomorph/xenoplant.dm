
///Those structures need time to grow and are supposed to be extremely weak healh-wise
/obj/structure/tyranid/plant
	name = "Tyranid Plant"
	max_integrity = 5
	icon = 'modular_imperium/master_files/icons/tyranid/plants.dmi'
	interaction_flags = INTERACT_CHECK_INCAPACITATED
	///The plant's icon once it's fully grown
	var/mature_icon_state
	///Is the plant ready to be used ?
	var/mature = FALSE
	///How long does it take for the plant to be useable
	var/maturation_time = 2 MINUTES

/obj/structure/tyranid/plant/Initialize(mapload, _hivenumber)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(on_mature)), maturation_time)

/obj/structure/tyranid/plant/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(!mature && istyranid(user))
		balloon_alert(user, "Not fully grown")
		return FALSE

/obj/structure/tyranid/plant/update_icon_state()
	. = ..()
	icon_state = (mature) ? mature_icon_state : initial(icon_state)

///Called whenever someone uses the plant, tyranid or guardsman
/obj/structure/tyranid/plant/proc/on_use(mob/user)
	mature = FALSE
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(on_mature)), maturation_time)
	return TRUE

///Called when the plant reaches maturity
/obj/structure/tyranid/plant/proc/on_mature(mob/user)
	playsound(src, SFX_ALIEN_RESIN_BUILD, 25)
	mature = TRUE
	update_icon()

/obj/structure/tyranid/plant/attack_hand(mob/living/user)
	if(!can_interact(user))
		return ..()
	return on_use(user)

/obj/structure/tyranid/plant/attack_alien(mob/living/carbon/tyranid/tyranid_attacker, damage_amount = tyranid_attacker.tyranid_caste.melee_damage, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = tyranid_attacker.tyranid_caste.melee_ap, isrightclick = FALSE)
	if((tyranid_attacker.status_flags & INCORPOREAL))
		return FALSE

	if(tyranid_attacker.a_intent == INTENT_HARM && istyraniddrone(tyranid_attacker))
		balloon_alert(tyranid_attacker, "Uprooted the plant")
		tyranid_attacker.do_attack_animation(src)
		deconstruct(TRUE)
		return FALSE
	if(can_interact(tyranid_attacker))
		return on_use(tyranid_attacker)
	return TRUE

/obj/structure/tyranid/plant/heal_fruit
	name = "life fruit"
	desc = "It would almost be appetizing wasn't it for the green colour and the shifting fluids inside..."
	icon_state = "heal_fruit_immature"
	mature_icon_state = "heal_fruit"
	///Minimum amount of health recovered
	var/healing_amount_min = 125
	///Maximum amount of health recovered, depends on the tyranid's max health
	var/healing_amount_max_health_scaling = 0.5

/obj/structure/tyranid/plant/heal_fruit/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!disassembled && mature)
		var/datum/effect_system/smoke_spread/tyranid/acid/opaque/plant_explosion = new(get_turf(src))
		plant_explosion.set_up(3,src)
		plant_explosion.start()
		visible_message(span_danger("[src] bursts, releasing toxic gas!"))
	return ..()

/obj/structure/tyranid/plant/heal_fruit/on_use(mob/user)
	balloon_alert(user, "Consuming...")
	if(!do_after(user, 2 SECONDS, IGNORE_HELD_ITEM, src))
		return FALSE
	if(!istyranid(user))
		deconstruct(FALSE)
		return TRUE

	var/mob/living/carbon/tyranid/X = user
	var/heal_amount = max(healing_amount_min, healing_amount_max_health_scaling * X.tyranid_caste.max_health)
	HEAL_TYRANID_DAMAGE(X, heal_amount, FALSE)
	playsound(user, SFX_ALIEN_DROOL, 25)
	balloon_alert(X, "Health restored")
	to_chat(X, span_tyranidwarning("We feel a sudden soothing chill as [src] tends to our wounds."))

	return ..()

/obj/structure/tyranid/plant/armor_fruit
	name = "hard fruit"
	desc = "The contents of this fruit are protected by a tough outer shell."
	icon_state = "armor_fruit_immature"
	mature_icon_state = "armor_fruit"
	///How much total sunder should we remove
	var/sunder_removal = 30

/obj/structure/tyranid/plant/armor_fruit/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!disassembled && mature)
		for (var/mob/living/carbon/human/nearby_human AS in cheap_get_humans_near(src, 1))
			var/turf/far_away_lands = get_turf(nearby_human)
			for(var/x in 1 to 20)
				var/turf/next_turf = get_step(far_away_lands, REVERSE_DIR(nearby_human.dir))
				if(!next_turf)
					break
				far_away_lands = next_turf

			nearby_human.throw_at(far_away_lands, 20, spin = TRUE)
			to_chat(nearby_human, span_warning("[src] bursts, releasing a strong gust of pressurised gas!"))
			nearby_human.adjust_stagger(3 SECONDS)
			nearby_human.apply_damage(30, BRUTE, "chest", BOMB)
	return ..()

/obj/structure/tyranid/plant/armor_fruit/on_use(mob/user)
	balloon_alert(user, "Consuming...")
	if(!do_after(user, 2 SECONDS, IGNORE_HELD_ITEM, src))
		return FALSE
	if(!istyranid(user))
		deconstruct(FALSE)
		return TRUE

	balloon_alert(user, "Armor restored")
	to_chat(user, span_tyranidwarning("We shed our shattered scales as new ones grow to replace them!"))
	var/mob/living/carbon/tyranid/X = user
	X.adjust_sunder(-sunder_removal)
	playsound(user, SFX_ALIEN_DROOL, 25)
	return ..()

/obj/structure/tyranid/plant/plasma_fruit
	name = "power fruit"
	desc = "A cyan fruit, beating like a creature's heart"
	icon_state = "plasma_fruit_immature"
	mature_icon_state = "plasma_fruit"
	///How much bonus plasma should we restore during the duration, 1 being 100% from base regen
	var/bonus_regen = 1
	///How long should the buff last
	var/duration = 1 MINUTES

/obj/structure/tyranid/plant/plasma_fruit/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!disassembled && mature)
		var/datum/effect_system/smoke_spread/tyranid/pyrogen_fire/plant_explosion = new(get_turf(src))
		plant_explosion.set_up(4, src)
		plant_explosion.start()
		visible_message(span_warning("[src] bursts, releasing blue hot gas!"))
	return ..()

/obj/structure/tyranid/plant/plasma_fruit/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(!istyranid(user))
		return
	var/mob/living/carbon/tyranid/X = user
	if(X.has_status_effect(STATUS_EFFECT_PLASMA_SURGE))
		balloon_alert(X, "Already increased plasma regen")
		return FALSE

/obj/structure/tyranid/plant/plasma_fruit/on_use(mob/user)
	balloon_alert(user, "Consuming...")
	if(!do_after(user, 2 SECONDS, IGNORE_HELD_ITEM, src))
		return FALSE
	if(!istyranid(user))
		deconstruct(FALSE)
		return TRUE

	var/mob/living/carbon/tyranid/X = user
	if(!(X.tyranid_caste.can_flags & CASTE_CAN_BE_GIVEN_PLASMA))
		to_chat(X, span_tyranidwarning("But our body rejects the fruit, we do not share the same plasma type!"))
		return FALSE
	X.apply_status_effect(/datum/status_effect/plasma_surge, X.tyranid_caste.plasma_max, bonus_regen, duration)
	balloon_alert(X, "Plasma restored")
	to_chat(X, span_tyranidwarning("[src] Restores our plasma reserves, our organism is on overdrive!"))
	playsound(user, SFX_ALIEN_DROOL, 25)
	return ..()


/obj/structure/tyranid/plant/stealth_plant
	name = "night shade"
	desc = "A beautiful flower, what purpose it could serve to the alien hive is beyond you however..."
	icon_state = "stealth_plant_immature"
	mature_icon_state = "stealth_plant"
	maturation_time = 4 MINUTES
	///The radius of the passive structure camouflage, requires line of sight
	var/camouflage_range = 7
	///The range of the active stealth ability, does not require line of sight
	var/active_camouflage_pulse_range = 10
	///How long should veil last
	var/active_camouflage_duration = 20 SECONDS
	///How long until the plant can be activated again
	var/cooldown = 2 MINUTES
	///Is the active ability veil on cooldown ?
	var/on_cooldown = FALSE
	///The list of passively camouflaged structures
	var/list/obj/structure/tyranid/camouflaged_structures = list()
	////The list of actively camouflaged tyranids by veil
	var/list/mob/living/carbon/tyranid/camouflaged_tyranids = list()

/obj/structure/tyranid/plant/stealth_plant/on_mature(mob/user)
	. = ..()
	START_PROCESSING(SSslowprocess, src)

/obj/structure/tyranid/plant/stealth_plant/Destroy()
	for(var/obj/structure/tyranid/tyranid_struct AS in camouflaged_structures)
		tyranid_struct.alpha = initial(tyranid_struct.alpha)
	unveil()
	STOP_PROCESSING(SSslowprocess, src)
	return ..()

/obj/structure/tyranid/plant/stealth_plant/process()
	for(var/turf/tile AS in RANGE_TURFS(camouflage_range, loc))
		for(var/obj/structure/tyranid/tyranid_struct in tile)
			if(istype(tyranid_struct, /obj/structure/tyranid/plant) || !line_of_sight(src, tyranid_struct)) //We don't hide plants
				continue
			camouflaged_structures.Add(tyranid_struct)
			tyranid_struct.alpha = STEALTH_PLANT_PASSIVE_CAMOUFLAGE_ALPHA

/obj/structure/tyranid/plant/stealth_plant/can_interact(mob/user)
	. = ..()
	if(!.)
		return FALSE
	if(ishuman(user))
		balloon_alert(user, "Nothing happens")
		to_chat(user, span_notice("You caress [src]'s petals, nothing happens."))
		return FALSE
	if(on_cooldown)
		balloon_alert(user, "Not ready yet")
		to_chat(user, span_tyranidwarning("[src] soft light shimmers, we should give it more time to recover!"))
		return FALSE

/obj/structure/tyranid/plant/stealth_plant/on_use(mob/user)
	balloon_alert(user, "Shaking...")
	if(!do_after(user, 2 SECONDS, IGNORE_HELD_ITEM, src))
		return FALSE
	visible_message(span_danger("[src] releases a burst of glowing pollen!"))
	veil()
	return TRUE

///Hides all nearby tyranids
/obj/structure/tyranid/plant/stealth_plant/proc/veil()
	for(var/turf/tile in RANGE_TURFS(camouflage_range, loc))
		for(var/mob/living/carbon/tyranid/X in tile)
			if(X.stat == DEAD || istyranidhunter(X) || X.alpha != 255) //We don't mess with tyranids capable of going stealth by themselves
				continue
			X.alpha = HUNTER_STEALTH_RUN_ALPHA
			new /obj/effect/temp_visual/alien_fruit_eaten(get_turf(X))
			balloon_alert(X, "We now blend in")
			to_chat(X, span_tyranidwarning("The pollen from [src] reacts with our scales, we are blending with our surroundings!"))
			camouflaged_tyranids.Add(X)
	on_cooldown = TRUE
	addtimer(CALLBACK(src, PROC_REF(unveil)), active_camouflage_duration)
	addtimer(CALLBACK(src, PROC_REF(ready)), cooldown)

///Called when veil() can be used once again
/obj/structure/tyranid/plant/stealth_plant/proc/ready()
	visible_message(span_danger("[src] petals shift in hue, it is ready to release more pollen."))
	on_cooldown = FALSE

///Reveals all tyranids hidden by veil()
/obj/structure/tyranid/plant/stealth_plant/proc/unveil()
	for(var/mob/living/carbon/tyranid/X AS in camouflaged_tyranids)
		X.alpha = initial(X.alpha)
		balloon_alert(X, "Effect wears off")
		to_chat(X, span_tyranidwarning("The effect of [src] wears off!"))
