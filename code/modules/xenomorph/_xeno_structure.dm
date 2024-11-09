/obj/structure/tyranid
	hit_sound = SFX_ALIEN_RESIN_BREAK
	layer = RESIN_STRUCTURE_LAYER
	resistance_flags = UNACIDABLE
	///Bitflags specific to tyranid structures
	var/tyranid_structure_flags
	///Which hive(number) do we belong to?
	var/hivenumber = TYRANID_HIVE_NORMAL

/obj/structure/tyranid/Initialize(mapload, _hivenumber)
	. = ..()
	if(!(tyranid_structure_flags & IGNORE_WEED_REMOVAL))
		RegisterSignal(loc, COMSIG_TURF_WEED_REMOVED, PROC_REF(weed_removed))
	if(_hivenumber) ///because admins can spawn them
		hivenumber = _hivenumber
	LAZYADDASSOC(GLOB.tyranid_structures_by_hive, hivenumber, src)
	if(tyranid_structure_flags & CRITICAL_STRUCTURE)
		LAZYADDASSOC(GLOB.tyranid_critical_structures_by_hive, hivenumber, src)

/obj/structure/tyranid/Destroy()
	if(!locate(src) in GLOB.tyranid_structures_by_hive[hivenumber]+GLOB.tyranid_critical_structures_by_hive[hivenumber]) //The rest of the proc is pointless to look through if its not in the lists
		stack_trace("[src] not found in the list of (potentially critical) tyranid structures!") //We dont want to CRASH because that'd block deletion completely. Just trace it and continue.
		return ..()
	GLOB.tyranid_structures_by_hive[hivenumber] -= src
	if(tyranid_structure_flags & CRITICAL_STRUCTURE)
		GLOB.tyranid_critical_structures_by_hive[hivenumber] -= src
	return ..()

/obj/structure/tyranid/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			take_damage(210, BRUTE, BOMB)
		if(EXPLODE_HEAVY)
			take_damage(140, BRUTE, BOMB)
		if(EXPLODE_LIGHT)
			take_damage(70, BRUTE, BOMB)
		if(EXPLODE_WEAK)
			take_damage(35, BRUTE, BOMB)

/obj/structure/tyranid/attack_hand(mob/living/user)
	balloon_alert(user, "You only scrape at it")
	return TRUE

/obj/structure/tyranid/fire_act(burn_level)
	take_damage(burn_level / 3, BURN, FIRE)

/// Destroy the tyranid structure when the weed it was on is destroyed
/obj/structure/tyranid/proc/weed_removed()
	SIGNAL_HANDLER
	obj_destruction(damage_flag = MELEE)

/obj/structure/tyranid/attack_alien(mob/living/carbon/tyranid/tyranid_attacker, damage_amount = tyranid_attacker.tyranid_caste.melee_damage, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = tyranid_attacker.tyranid_caste.melee_ap, isrightclick = FALSE)
	if(!(HAS_TRAIT(tyranid_attacker, TRAIT_VALHALLA_TYRANID) && tyranid_attacker.a_intent == INTENT_HARM && (tgui_alert(tyranid_attacker, "Are you sure you want to tear down [src]?", "Tear down [src]?", list("Yes","No"))) == "Yes"))
		return ..()
	if(!do_after(tyranid_attacker, 3 SECONDS, NONE, src))
		return
	tyranid_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	balloon_alert_to_viewers("\The [tyranid_attacker] tears down \the [src]!", "We tear down \the [src].")
	playsound(src, SFX_ALIEN_RESIN_BREAK, 25)
	take_damage(max_integrity) // Ensure its destroyed
