//! TODO: this needs a refactor/UI rewor at some point, we've probably bolted too much onto this over time

/// Empty datum parent for use as evolution panel entrance.
/datum/evolution_panel
	// Empty

/// Controls the evolution UI
/datum/evolution_panel/ui_interact(mob/user, datum/tgui/ui)
	// Tyranid only screen
	if(!istyranid(user))
		return

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HiveEvolveScreen")
		ui.open()

/// Checks for tyranid access and prevents unconscious / dead tyranids from interacting.
/datum/evolution_panel/ui_state(mob/user)
	return GLOB.tyranid_state

/// Static data provided once when the ui is opened
/datum/evolution_panel/ui_static_data(mob/living/carbon/tyranid/tyranid)
	. = list()
	.["name"] = tyranid.tyranid_caste.display_name
	.["abilities"] = list()
	for(var/ability in tyranid.tyranid_caste.actions)
		var/datum/action/ability/tyranid_action/tyranid_ability = ability
		if(SSticker.mode && !(SSticker.mode.tyranid_abilities_flags & initial(tyranid_ability.gamemode_flags)))
			continue
		.["abilities"]["[ability]"] = list(
			"name" = initial(tyranid_ability.name),
			"desc" = initial(tyranid_ability.desc),
			"cost" = initial(tyranid_ability.ability_cost),
			"cooldown" = (initial(tyranid_ability.cooldown_duration) / 10)
		)
	.["evolves_to"] = list()
	for(var/evolves_into in tyranid.get_evolution_options())
		var/datum/tyranid_caste/caste = GLOB.tyranid_caste_datums[evolves_into][TYRANID_UPGRADE_BASETYPE]
		var/list/caste_data = list(
			"type_path" = caste.type,
			"name" = caste.display_name,
			"abilities" = list(),
			"instant_evolve" = (caste.caste_flags & CASTE_INSTANT_EVOLUTION || (HAS_TRAIT(tyranid, TRAIT_STRAIN_SWAP) || HAS_TRAIT(tyranid, TRAIT_CASTE_SWAP) || HAS_TRAIT(tyranid, TRAIT_REGRESSING))),
		)
		for(var/ability in caste.actions)
			var/datum/action/ability/tyranid_action/tyranid_ability = ability
			if(SSticker.mode && !(SSticker.mode.tyranid_abilities_flags & initial(tyranid_ability.gamemode_flags)))
				continue
			caste_data["abilities"]["[ability]"] = list(
				"name" = initial(tyranid_ability.name),
				"desc" = initial(tyranid_ability.desc),
				"cost" = initial(tyranid_ability.ability_cost),
				"cooldown" = (initial(tyranid_ability.cooldown_duration) / 10)
			)
		.["evolves_to"]["[caste.caste_type_path]"] = caste_data

/// Some data to update the UI with the current evolution status
/datum/evolution_panel/ui_data(mob/living/carbon/tyranid/tyranid)
	var/list/data = list()

	if(iscrashgamemode(SSticker.mode))
		var/datum/game_mode/infestation/crash/crash_mode = SSticker.mode
		data["bypass_evolution_checks"] = !crash_mode.shuttle_landed
	else
		data["bypass_evolution_checks"] = (SSticker.mode?.round_type_flags & MODE_ALLOW_TYRANID_QUICKBUILD) && SSresinshaping.active

	data["can_evolve"] = \
		!tyranid.is_ventcrawling && \
		!tyranid.incapacitated(TRUE) && \
		tyranid.health >= tyranid.maxHealth && \
		tyranid.plasma_stored >= (tyranid.tyranid_caste.plasma_max * tyranid.tyranid_caste.plasma_regen_limit)

	data["evolution"] = list(
		"current" = tyranid.evolution_stored,
		"max" = tyranid.tyranid_caste.evolution_threshold
	)

	return data

/// Handles actuually evolving
/datum/evolution_panel/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/mob/living/carbon/tyranid/tyranid = usr
	switch(action)
		if("evolve")
			var/newpath = text2path(params["path"])
			if(!newpath)
				return
			var/datum/tyranid_caste/caste = GLOB.tyranid_caste_datums[newpath][TYRANID_UPGRADE_BASETYPE]
			if(!caste)
				return
			tyranid.do_evolve(caste.type, (HAS_TRAIT(tyranid, TRAIT_CASTE_SWAP) || HAS_TRAIT(tyranid, TRAIT_REGRESSING)|| HAS_TRAIT(tyranid, TRAIT_STRAIN_SWAP))) // All the checks for can or can't are handled inside do_evolve
			return TRUE

/datum/evolution_panel/ui_close(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_CASTE_SWAP, TRAIT_CASTE_SWAP)
	REMOVE_TRAIT(user, TRAIT_REGRESSING, TRAIT_REGRESSING)
	REMOVE_TRAIT(user, TRAIT_STRAIN_SWAP, TRAIT_STRAIN_SWAP)
