/*
* Data HUDs have been rewritten in a more generic way.
* In short, they now use an observer-listener pattern.
* See code/datum/hud.dm for the generic hud datum.
* Update the HUD icons when needed with the appropriate hook. (see below)
*/

/* DATA HUD DATUMS */

/atom/proc/add_to_all_mob_huds()
	return

/mob/living/carbon/human/add_to_all_mob_huds()
	for(var/h in GLOB.huds)
		if(istype(h, /datum/atom_hud/tyranid)) //this one is tyranid only
			continue
		var/datum/atom_hud/hud = h
		hud.add_to_hud(src)

/mob/living/carbon/tyranid/add_to_all_mob_huds()
	for(var/h in GLOB.huds)
		if(!istype(h, /datum/atom_hud/tyranid))
			continue
		var/datum/atom_hud/hud = h
		hud.add_to_hud(src)

/atom/proc/remove_from_all_mob_huds()
	return

/mob/living/carbon/human/remove_from_all_mob_huds()
	for(var/h in GLOB.huds)
		if(istype(h, /datum/atom_hud/tyranid))
			continue
		var/datum/atom_hud/hud = h
		hud.remove_from_hud(src)

/mob/living/carbon/tyranid/remove_from_all_mob_huds()
	for(var/h in GLOB.huds)
		if(!istype(h, /datum/atom_hud/tyranid))
			continue
		var/datum/atom_hud/hud = h
		hud.remove_from_hud(src)

/datum/atom_hud/simple //Naked-eye observable statuses.
	hud_icons = list(STATUS_HUD_SIMPLE)

/datum/atom_hud/medical
	hud_icons = list(HEALTH_HUD, STATUS_HUD)

//med hud used by silicons, only shows humans with a uniform with sensor mode activated.
/datum/atom_hud/medical/basic

/datum/atom_hud/medical/basic/proc/check_sensors(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	var/obj/item/clothing/under/U = H.w_uniform
	if(!istype(U))
		return FALSE
	if(U.sensor_mode <= 2)
		return FALSE
	return TRUE

/datum/atom_hud/medical/basic/add_to_single_hud(mob/user, mob/target)
	if(check_sensors(user))
		return ..()

/datum/atom_hud/medical/basic/proc/update_suit_sensors(mob/living/carbon/human/H)
	if(check_sensors(H))
		add_to_hud(H)
	else
		remove_from_hud(H)

/mob/living/carbon/human/proc/update_suit_sensors()
	var/datum/atom_hud/medical/basic/B = GLOB.huds[DATA_HUD_MEDICAL_BASIC]
	B.update_suit_sensors(src)

//med hud used by medical hud glasses
/datum/atom_hud/medical/advanced

//HUD used by the synth, separate typepath so it's not accidentally removed.
/datum/atom_hud/medical/advanced/synthetic

//medical hud used by ghosts
/datum/atom_hud/medical/observer
	hud_icons = list(HEALTH_HUD, TYRANID_EMBRYO_HUD, TYRANID_REAGENT_HUD, TYRANID_DEBUFF_HUD, STATUS_HUD, MACHINE_HEALTH_HUD, MACHINE_AMMO_HUD)

/datum/atom_hud/medical/pain
	hud_icons = list(PAIN_HUD)

/mob/proc/med_hud_set_health()
	return

/mob/living/carbon/tyranid/med_hud_set_health()
	if(hud_used?.healths)
		var/bucket
		if(stat == DEAD)
			bucket = "critical"
		else
			bucket = get_bucket(TYRANID_HUD_ICON_BUCKETS, maxHealth, health, get_crit_threshold(), list("full", "critical"))
		hud_used.healths.icon_state = "health[bucket]"

	var/image/holder = hud_list[HEALTH_HUD_TYRANID]
	if(!holder)
		return
	if(stat == DEAD)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
		holder.icon_state = "health0"
		return

	var/amount = health > 0 ? round(health * 100 / maxHealth, 10) : CEILING(health, 10)
	if(!amount && health < 0)
		amount = -1 //don't want the 'zero health' icon when we are crit
	holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
	holder.icon_state = "health[amount]"

/mob/living/carbon/human/med_hud_set_health()
	var/image/holder = hud_list[HEALTH_HUD]
	if(stat == DEAD)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/human_health.dmi'
		holder.icon_state = "health-100"
		return

	holder.icon = 'modular_imperium/master_files/icons/mob/hud/human_health.dmi'
	var/percentage = round(health * 100 / maxHealth)
	switch(percentage)
		if(100 to INFINITY)
			holder.icon_state = "health100"
		if(90 to 99)
			holder.icon_state = "health90"
		if(80 to 89)
			holder.icon_state = "health80"
		if(70 to 79)
			holder.icon_state = "health70"
		if(60 to 69)
			holder.icon_state = "health60"
		if(50 to 59)
			holder.icon_state = "health50"
		if(45 to 49)
			holder.icon_state = "health45"
		if(40 to 44)
			holder.icon_state = "health40"
		if(35 to 39)
			holder.icon_state = "health35"
		if(30 to 34)
			holder.icon_state = "health30"
		if(25 to 29)
			holder.icon_state = "health25"
		if(20 to 24)
			holder.icon_state = "health20"
		if(15 to 19)
			holder.icon_state = "health15"
		if(10 to 14)
			holder.icon_state = "health10"
		if(5 to 9)
			holder.icon_state = "health5"
		if(0 to 4)
			holder.icon_state = "health0"
		if(-49 to -1)
			holder.icon_state = "health-0"
		if(-99 to -50)
			holder.icon_state = "health-50"
		else
			holder.icon_state = "health-100"

/mob/proc/med_hud_set_status() //called when mob stat changes, or get a virus/tyranid host, etc
	return

/mob/living/carbon/tyranid/med_hud_set_status()
	hud_set_pheromone()

/mob/living/carbon/human/med_hud_set_status()
	var/image/status_hud = hud_list[STATUS_HUD] //Status for med-hud.
	var/image/infection_hud = hud_list[TYRANID_EMBRYO_HUD] //State of the tyranid embryo.
	var/image/simple_status_hud = hud_list[STATUS_HUD_SIMPLE] //Status for the naked eye.
	var/image/tyranid_reagent = hud_list[TYRANID_REAGENT_HUD] // Displays active tyranid reagents
	var/image/tyranid_debuff = hud_list[TYRANID_DEBUFF_HUD] //Displays active tyranid specific debuffs
	var/static/image/neurotox_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "neurotoxin")
	var/static/image/hemodile_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "hemodile")
	var/static/image/transvitox_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "transvitox")
	var/static/image/sanguinal_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "sanguinal")
	var/static/image/ozelomelyn_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "ozelomelyn")
	var/static/image/neurotox_high_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "neurotoxin_high")
	var/static/image/hemodile_high_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "hemodile_high")
	var/static/image/transvitox_high_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "transvitox_high")
	var/static/image/sanguinal_high_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "sanguinal_high")
	var/static/image/intoxicated_image = image('modular_imperium/master_files/icons/mob/hud/intoxicated.dmi', icon_state = "intoxicated")
	var/static/image/intoxicated_amount_image = image('modular_imperium/master_files/icons/mob/hud/intoxicated.dmi', icon_state = "intoxicated_amount0")
	var/static/image/intoxicated_high_image = image('modular_imperium/master_files/icons/mob/hud/intoxicated.dmi', icon_state = "intoxicated_high")
	var/static/image/hunter_silence_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "silence_debuff")
	var/static/image/hive_target_image = image('modular_imperium/master_files/icons/mob/hud/human.dmi', icon_state = "hive_target")

	tyranid_reagent.overlays.Cut()
	tyranid_reagent.icon_state = ""
	if(stat != DEAD)
		var/neurotox_amount = reagents.get_reagent_amount(/datum/reagent/toxin/tyranid_neurotoxin)
		var/hemodile_amount = reagents.get_reagent_amount(/datum/reagent/toxin/tyranid_hemodile)
		var/transvitox_amount = reagents.get_reagent_amount(/datum/reagent/toxin/tyranid_transvitox)
		var/sanguinal_amount = reagents.get_reagent_amount(/datum/reagent/toxin/tyranid_sanguinal)
		var/ozelomelyn_amount = reagents.get_reagent_amount(/datum/reagent/toxin/tyranid_ozelomelyn)

		if(neurotox_amount > 10) //Blinking image for particularly high concentrations
			tyranid_reagent.overlays += neurotox_high_image
		else if(neurotox_amount > 0)
			tyranid_reagent.overlays += neurotox_image

		if(ozelomelyn_amount > 0) // Has no effect beyond having it in them, don't need to have a high image.
			tyranid_reagent.overlays += ozelomelyn_image

		if(hemodile_amount > 10)
			tyranid_reagent.overlays += hemodile_high_image
		else if(hemodile_amount > 0)
			tyranid_reagent.overlays += hemodile_image

		if(transvitox_amount > 10)
			tyranid_reagent.overlays += transvitox_high_image
		else if(transvitox_amount > 0)
			tyranid_reagent.overlays += transvitox_image

		if(sanguinal_amount > 10)
			tyranid_reagent.overlays += sanguinal_high_image
		else if(sanguinal_amount > 0)
			tyranid_reagent.overlays += sanguinal_image

	hud_list[TYRANID_REAGENT_HUD] = tyranid_reagent

	//Tyranid debuff section start
	tyranid_debuff.overlays.Cut()
	tyranid_debuff.icon_state = ""
	if(stat != DEAD)
		if(IsMute())
			tyranid_debuff.overlays += hunter_silence_image

	if(HAS_TRAIT(src, TRAIT_HIVE_TARGET))
		tyranid_debuff.overlays += hive_target_image

	if(has_status_effect(STATUS_EFFECT_INTOXICATED))
		var/datum/status_effect/stacking/intoxicated/debuff = has_status_effect(STATUS_EFFECT_INTOXICATED)
		var/intoxicated_amount = debuff.stacks
		tyranid_debuff.overlays += intoxicated_amount_image
		intoxicated_amount_image.icon_state = "intoxicated_amount[intoxicated_amount]"
		if(intoxicated_amount > 15)
			tyranid_debuff.overlays += intoxicated_high_image
		else if(intoxicated_amount > 0)
			tyranid_debuff.overlays += intoxicated_image

	hud_list[TYRANID_DEBUFF_HUD] = tyranid_debuff

	status_hud.overlays.Cut()
	if(species.species_flags & IS_SYNTHETIC)
		simple_status_hud.icon_state = ""
		if(stat != DEAD)
			status_hud.icon_state = "synth"
			switch(round(health * 100 / maxHealth)) // special health HUD icons for damaged synthetics
				if(-29 to 4) // close to overheating: should appear when health is less than 5
					status_hud.icon_state = "synthsoftcrit"
				if(-INFINITY to -30) // dying
					status_hud.icon_state = "synthhardcrit"
		else if(HAS_TRAIT(src, TRAIT_UNDEFIBBABLE))
			status_hud.icon_state = "synthdnr"
			return TRUE
		else
			if(!mind)
				var/mob/dead/observer/ghost = get_ghost(TRUE)
				if(!ghost)
					status_hud.icon_state = "synthdnr"
					return TRUE
				if(!ghost.client) // DC'd ghost detected
					status_hud.overlays += "dead_noclient"
			if(!client && !get_ghost(TRUE)) // Nobody home, no ghost, must have disconnected while in their body
				status_hud.overlays += "dead_noclient"
			status_hud.icon_state = "synthdead"
			return TRUE
		infection_hud.icon_state = "synth" //Tyranids can feel synths are not human.
		return TRUE

	if(species.species_flags & HEALTH_HUD_ALWAYS_DEAD)
		status_hud.icon_state = "dead"
		infection_hud.icon_state = ""
		simple_status_hud.icon_state = ""
		return TRUE

	if(status_flags & TYRANID_HOST)
		var/obj/item/alien_embryo/E = locate(/obj/item/alien_embryo) in src
		if(E)
			infection_hud.icon = 'modular_imperium/master_files/icons/mob/hud/infected.dmi'
			if(E.boost_timer)
				infection_hud.icon_state = "infectedmodifier[E.stage]"
			else
				infection_hud.icon_state = "infected[E.stage]"
		else if(locate(/mob/living/carbon/tyranid/larva) in src)
			infection_hud.icon = 'modular_imperium/master_files/icons/mob/hud/infected.dmi'
			infection_hud.icon_state = "infected6"
		else
			infection_hud.icon_state = ""
	else
		infection_hud.icon_state = ""
	if(species.species_flags & ROBOTIC_LIMBS)
		simple_status_hud.icon_state = ""
		infection_hud.icon_state = "robot"

	switch(stat)
		if(DEAD)
			simple_status_hud.icon_state = ""
			infection_hud.icon_state = "dead"
			if(!HAS_TRAIT(src, TRAIT_PSY_DRAINED))
				infection_hud.icon_state = "psy_drain"
			if(HAS_TRAIT(src, TRAIT_UNDEFIBBABLE ))
				hud_list[HEART_STATUS_HUD].icon_state = "still_heart"
				status_hud.icon_state = "dead"
				return TRUE
			if(!mind)
				var/mob/dead/observer/ghost = get_ghost(TRUE)
				if(!ghost) // No ghost detected. DNR player or NPC
					status_hud.icon_state = "dead_dnr"
					return TRUE
				if(!ghost.client) // DC'd ghost detected
					status_hud.overlays += "dead_noclient"
			if(!client && !get_ghost(TRUE)) // Nobody home, no ghost, must have disconnected while in their body
				status_hud.overlays += "dead_noclient"
			var/stage
			switch(dead_ticks)
				if(0 to 0.4 * TIME_BEFORE_DNR)
					stage = 1
				if(0.4 * TIME_BEFORE_DNR to 0.8 * TIME_BEFORE_DNR)
					stage = 2
				if(0.8 * TIME_BEFORE_DNR to INFINITY)
					stage = 3
			status_hud.icon_state = "dead_defib[stage]"
			return TRUE
		if(UNCONSCIOUS)
			if(!client) //Nobody home.
				simple_status_hud.icon_state = "afk"
				status_hud.icon_state = "afk"
				return TRUE
			if(IsUnconscious()) //Should hopefully get out of it soon.
				simple_status_hud.icon_state = "knockout"
				status_hud.icon_state = "knockout"
				return TRUE
			status_hud.icon_state = "sleep" //Regular sleep, else.
			simple_status_hud.icon_state = "sleep"
			return TRUE
		if(CONSCIOUS)
			if(!key) //Nobody home. Shouldn't affect aghosting.
				simple_status_hud.icon_state = "afk"
				status_hud.icon_state = "afk"
				return TRUE
			if(IsParalyzed()) //I've fallen and I can't get up.
				simple_status_hud.icon_state = "knockdown"
				status_hud.icon_state = "knockdown"
				return TRUE
			if(IsStun())
				simple_status_hud.icon_state = "stun"
				status_hud.icon_state = "stun"
				return TRUE
			if(IsStaggered())
				simple_status_hud.icon_state = "stagger"
				status_hud.icon_state = "stagger"
				return TRUE
			if(slowdown)
				simple_status_hud.icon_state = "slowdown"
				status_hud.icon_state = "slowdown"
				return TRUE
			else
				if(species.species_flags & ROBOTIC_LIMBS)
					simple_status_hud.icon_state = ""
					status_hud.icon_state = "robot"
					return TRUE
				else
					simple_status_hud.icon_state = ""
					status_hud.icon_state = "healthy"
					return TRUE

#define HEALTH_RATIO_PAIN_HUD 1
#define PAIN_RATIO_PAIN_HUD 0.25
#define STAMINA_RATIO_PAIN_HUD 0.25

/mob/proc/med_pain_set_perceived_health()
	return

/mob/living/carbon/human/med_pain_set_perceived_health()
	if(species?.species_flags & IS_SYNTHETIC)
		return FALSE

	var/image/holder = hud_list[PAIN_HUD]
	if(stat == DEAD)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/human_health.dmi'
		holder.icon_state = "health-100"
		return TRUE

	var/perceived_health = health / maxHealth * 100
	if(!(species.species_flags & NO_PAIN))
		perceived_health -= PAIN_RATIO_PAIN_HUD * traumatic_shock
	if(!(species.species_flags & NO_STAMINA) && staminaloss > 0)
		perceived_health -= STAMINA_RATIO_PAIN_HUD * staminaloss

	holder.icon = 'modular_imperium/master_files/icons/mob/hud/human_health.dmi'
	if(perceived_health >= 100)
		holder.icon_state = "health100"
	else if(perceived_health > 0)
		holder.icon_state = "health[round(perceived_health, 10)]"
	else if(health > (health_threshold_dead * 0.5))
		holder.icon_state = "health-0"
	else
		holder.icon_state = "health-50"

	return TRUE

//infection status that appears on humans and monkeys, viewed by tyranids only.
/datum/atom_hud/tyranid_infection
	hud_icons = list(TYRANID_EMBRYO_HUD)

//active reagent hud that apppears only for tyranids
/datum/atom_hud/tyranid_reagents
	hud_icons = list(TYRANID_REAGENT_HUD)

///hud component for revealing tactical elements to tyranids
/datum/atom_hud/tyranid_tactical
	hud_icons = list(TYRANID_TACTICAL_HUD)

///hud component for revealing tyranid specific status effect debuffs to tyranids
/datum/atom_hud/tyranid_debuff
	hud_icons = list(TYRANID_DEBUFF_HUD)

//Tyranid status hud, for tyranids
/datum/atom_hud/tyranid
	hud_icons = list(HEALTH_HUD_TYRANID, PLASMA_HUD, PHEROMONE_HUD, QUEEN_OVERWATCH_HUD, ARMOR_SUNDER_HUD, TYRANID_FIRE_HUD, TYRANID_RANK_HUD, TYRANID_BLESSING_HUD, TYRANID_EVASION_HUD)

/datum/atom_hud/tyranid_heart
	hud_icons = list(HEART_STATUS_HUD)

/mob/living/proc/hud_set_sunder()
	return

/mob/living/carbon/tyranid/hud_set_sunder()
	var/image/holder = hud_list[ARMOR_SUNDER_HUD]
	if(!holder)
		return

	if(stat == DEAD)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
		holder.icon_state = "sundering0"
		return

	var/amount = min(round(sunder * 100 / tyranid_caste.sunder_max, 10), 100)
	holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
	holder.icon_state = "sundering[amount]"

///Set fire stacks on the hud
/mob/living/proc/hud_set_firestacks()
	return

/mob/living/carbon/tyranid/hud_set_firestacks()
	var/image/holder = hud_list[TYRANID_FIRE_HUD]
	if(!holder)
		return

	if(stat == DEAD)
		holder.icon_state = ""
		return
	switch(fire_stacks)
		if(-INFINITY to 0)
			holder.icon_state = ""
		if(1 to 5)
			holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno.dmi'
			holder.icon_state = "firestack1"
		if(6 to 10)
			holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno.dmi'
			holder.icon_state = "firestack2"
		if(11 to 15)
			holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno.dmi'
			holder.icon_state = "firestack3"
		if(16 to INFINITY)
			holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno.dmi'
			holder.icon_state = "firestack4"

/mob/living/carbon/tyranid/proc/hud_set_plasma()
	if(!tyranid_caste) //this is cringe that we need this but currently its called before caste is set on init
		return
	if(hud_used?.alien_plasma_display)
		var/bucket
		if(stat == DEAD)
			bucket = "empty"
		else
			bucket = get_bucket(TYRANID_HUD_ICON_BUCKETS, tyranid_caste.plasma_max, plasma_stored, 0, list("full", "empty"))
		hud_used.alien_plasma_display.icon_state = "power_display_[bucket]"

	var/image/holder = hud_list[PLASMA_HUD]
	if(!holder)
		return
	holder.overlays.Cut()
	if(stat == DEAD)
		return
	holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
	var/plasma_amount = tyranid_caste.plasma_max? round(plasma_stored * 100 / tyranid_caste.plasma_max, 10) : 0
	holder.overlays += tyranid_caste.plasma_icon_state? "[tyranid_caste.plasma_icon_state][plasma_amount]" : null
	var/wrath_amount = tyranid_caste.wrath_max? round(wrath_stored * 100 / tyranid_caste.wrath_max, 10) : 0
	holder.overlays += "wrath[wrath_amount]"

/mob/living/carbon/tyranid/proc/hud_set_pheromone()
	var/image/holder = hud_list[PHEROMONE_HUD]
	if(!holder)
		return
	holder.icon_state = ""
	if(stat != DEAD)
		var/tempname = ""
		if(frenzy_aura)
			tempname += AURA_TYRANID_FRENZY
		if(warding_aura)
			tempname += AURA_TYRANID_WARDING
		if(recovery_aura)
			tempname += AURA_TYRANID_RECOVERY
		if(tempname)
			holder.icon = 'modular_imperium/master_files/icons/mob/hud/aura.dmi'
			holder.icon_state = "[tempname]"

	hud_list[PHEROMONE_HUD] = holder

//Only called when an aura is added or removed
/mob/living/carbon/tyranid/update_aura_overlay()
	var/image/holder = hud_list[PHEROMONE_HUD]
	if(!holder)
		return
	holder.overlays.Cut()
	if(stat == DEAD)
		return
	for(var/aura_type in GLOB.pheromone_images_list)
		if(emitted_auras.Find(aura_type))
			holder.overlays += image('modular_imperium/master_files/icons/mob/hud/aura.dmi', src, "[aura_type]_aura")

/mob/living/carbon/tyranid/proc/hud_set_queen_overwatch()
	var/image/holder = hud_list[QUEEN_OVERWATCH_HUD]
	holder.overlays.Cut()
	holder.icon_state = ""
	if(stat != DEAD)
		if(hive?.living_tyranid_queen)
			if(hive.living_tyranid_queen.observed_tyranid == src)
				holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno.dmi'
				holder.icon_state = "queen_overwatch"
			if(tyranid_flags & TYRANID_LEADER)
				var/image/I = image('modular_imperium/master_files/icons/mob/hud/xeno.dmi',src, "leader")
				holder.overlays += I
	hud_list[QUEEN_OVERWATCH_HUD] = holder

/mob/living/carbon/tyranid/proc/hud_update_rank()
	var/image/holder = hud_list[TYRANID_RANK_HUD]
	holder.icon_state = ""
	if(stat != DEAD && playtime_as_number() > 0 && client.prefs.show_tyranid_rank)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno.dmi'
		holder.icon_state = "upgrade_[playtime_as_number()]"

	hud_list[TYRANID_RANK_HUD] = holder

/datum/atom_hud/security
	hud_icons = list(WANTED_HUD)

/mob/living/carbon/human/proc/sec_hud_set_security_status()
	var/image/holder = hud_list[WANTED_HUD]
	holder.icon_state = ""
	var/perpname = name
	var/obj/item/card/id/I = get_idcard()
	if(istype(I))
		perpname = I.registered_name

	for(var/datum/data/record/E in GLOB.datacore.general) // someone should either delete or fix this
		if(E.fields["name"] == perpname)
			for(var/datum/data/record/R in GLOB.datacore.security)
				if((R.fields["id"] == E.fields["id"]) && (R.fields["criminal"] == "*Arrest*"))
					holder.icon_state = "wanted"
					break
				else if((R.fields["id"] == E.fields["id"]) && (R.fields["criminal"] == "Incarcerated"))
					holder.icon_state = "prisoner"
					break
				else if((R.fields["id"] == E.fields["id"]) && (R.fields["criminal"] == "Released"))
					holder.icon_state = "released"
					break

/datum/atom_hud/squad
	hud_icons = list(SQUAD_HUD_IMPERIUM, MACHINE_HEALTH_HUD, MACHINE_AMMO_HUD)

/datum/atom_hud/squad_chaos
	hud_icons = list(SQUAD_HUD_CHAOS, MACHINE_HEALTH_HUD, MACHINE_AMMO_HUD)

/mob/proc/hud_set_job(faction = FACTION_IMPERIUM)
	return

/mob/living/carbon/human/hud_set_job(faction = FACTION_IMPERIUM)
	var/hud_type
	switch(faction)
		if(FACTION_IMPERIUM)
			hud_type = SQUAD_HUD_IMPERIUM
		if(FACTION_CHAOS)
			hud_type = SQUAD_HUD_CHAOS
		else
			return
	var/image/holder = hud_list[hud_type]
	holder.icon_state = ""
	holder.overlays.Cut()

	if(assigned_squad)
		var/squad_color = assigned_squad.color
		var/rank = job.comm_title
		if(job.job_flags & JOB_FLAG_PROVIDES_SQUAD_HUD)
			var/image/IMG = image('modular_imperium/master_files/icons/mob/hud/job.dmi', src, "")
			IMG.color = squad_color
			holder.overlays += IMG
			holder.overlays += image('modular_imperium/master_files/icons/mob/hud/job.dmi', src, "[rank]")
			if(assigned_squad?.squad_leader == src)
				holder.overlays += image('modular_imperium/master_files/icons/mob/hud/job.dmi', src, "leader_trim")
		var/fireteam = wear_id?.assigned_fireteam
		if(fireteam)
			var/image/IMG2 = image('modular_imperium/master_files/icons/mob/hud/job.dmi', src, "fireteam_[fireteam]")
			IMG2.color = squad_color
			holder.overlays += IMG2

	else if(job.job_flags & JOB_FLAG_PROVIDES_SQUAD_HUD)
		holder.overlays += image('modular_imperium/master_files/icons/mob/hud/job.dmi', src, "[job.comm_title]")

	hud_list[hud_type] = holder

/datum/atom_hud/order
	hud_icons = list(ORDER_HUD)

///Updates aura hud icons
/mob/living/carbon/human/proc/hud_set_order()
	var/image/holder = hud_list[ORDER_HUD]
	holder.overlays.Cut()
	if(stat == DEAD)
		return
	var/static/image/mobility_icon = image(icon = 'modular_imperium/master_files/icons/mob/hud/aura.dmi', icon_state = "move")
	var/static/image/protection_icon = image(icon = 'modular_imperium/master_files/icons/mob/hud/aura.dmi', icon_state = "hold")
	var/static/image/marksman_icon = image(icon = 'modular_imperium/master_files/icons/mob/hud/aura.dmi', icon_state = "focus")
	var/static/image/flag_icon = image(icon = 'modular_imperium/master_files/icons/mob/hud/aura.dmi', icon_state = "flag")
	var/static/image/flag_lost_icon = image(icon = 'modular_imperium/master_files/icons/mob/hud/aura.dmi', icon_state = "flag_lost")

	if(mobility_aura)
		holder.add_overlay(mobility_icon)
	if(protection_aura)
		holder.add_overlay(protection_icon)
	if(marksman_aura)
		holder.add_overlay(marksman_icon)
	if(flag_aura > 0)
		holder.add_overlay(flag_icon)
	else if(flag_aura < 0)
		holder.add_overlay(flag_lost_icon)

	update_aura_overlay()

//Only called when an aura is added or removed
/mob/living/carbon/human/update_aura_overlay()
	var/image/holder = hud_list[ORDER_HUD]
	var/static/image/mobility_source = image(icon = 'modular_imperium/master_files/icons/mob/hud/aura.dmi', icon_state = "move_aura")
	var/static/image/protection_source = image(icon = 'modular_imperium/master_files/icons/mob/hud/aura.dmi', icon_state = "hold_aura")
	var/static/image/marksman_source = image(icon = 'modular_imperium/master_files/icons/mob/hud/aura.dmi', icon_state = "focus_aura")

	emitted_auras.Find(AURA_HUMAN_MOVE) ? holder.add_overlay(mobility_source) : holder.cut_overlay(mobility_source)
	emitted_auras.Find(AURA_HUMAN_HOLD) ? holder.add_overlay(protection_source) : holder.cut_overlay(protection_source)
	emitted_auras.Find(AURA_HUMAN_FOCUS) ? holder.add_overlay(marksman_source) : holder.cut_overlay(marksman_source)

///Makes sentry health visible
/obj/proc/hud_set_machine_health()
	var/image/holder = hud_list[MACHINE_HEALTH_HUD]

	if(!holder)
		return

	if(obj_integrity < 1)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
		holder.icon_state = "health0"
		return

	var/amount = round(obj_integrity * 100 / max_integrity, 10)
	if(!amount)
		amount = 1 //don't want the 'zero health' icon when we still have 4% of our health
	holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
	holder.icon_state = "health[amount]"

///Makes mounted guns ammo visible
/obj/machinery/deployable/mounted/proc/hud_set_gun_ammo()
	var/image/holder = hud_list[MACHINE_AMMO_HUD]

	if(!holder)
		return
	var/obj/item/weapon/gun/internal_gun = internal_item.resolve()
	if(!internal_gun?.rounds)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
		holder.icon_state = "plasma0"
		return
	var/amount = internal_gun.max_rounds ? round(internal_gun.rounds * 100 / internal_gun.max_rounds, 10) : 0
	holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
	holder.icon_state = "plasma[amount]"

///Makes unmanned vehicle ammo visible
/obj/vehicle/unmanned/proc/hud_set_uav_ammo()
	var/image/holder = hud_list[MACHINE_AMMO_HUD]

	if(!holder)
		return

	if(!current_rounds)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
		holder.icon_state = "plasma0"
		return

	var/amount = round(current_rounds * 100 / max_rounds, 10)
	holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
	holder.icon_state = "plasma[amount]"

///Mecha health hud updates
/obj/vehicle/sealed/mecha/proc/hud_set_mecha_health()
	var/image/holder = hud_list[MACHINE_HEALTH_HUD]

	if(!holder)
		return

	if(obj_integrity < 1)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
		holder.icon_state = "health0"
		return

	var/amount = round(obj_integrity * 100 / max_integrity, 10)
	if(!amount)
		amount = 1 //don't want the 'zero health' icon when we still have 4% of our health
	holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
	holder.icon_state = "health[amount]"

///Updates mecha battery
/obj/vehicle/sealed/mecha/proc/hud_set_mecha_battery()
	var/image/holder = hud_list[MACHINE_AMMO_HUD]

	if(!holder)
		return

	if(!cell)
		holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
		holder.icon_state = "plasma0"
		return

	var/amount = round(cell.charge * 100 / cell.maxcharge, 10)
	holder.icon = 'modular_imperium/master_files/icons/mob/hud/xeno_health.dmi'
	holder.icon_state = "plasma[amount]"

/obj/vehicle/sealed/mecha/proc/diag_hud_set_mechstat()
	var/image/holder = hud_list[ORDER_HUD]
	if(!holder)
		return
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	if(internal_damage)
		holder.icon_state = "hudwarn"
	holder.icon_state = null
