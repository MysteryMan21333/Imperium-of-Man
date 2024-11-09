
/mob/living/carbon/tyranid/proc/upgrade_tyranid(newlevel, silent = FALSE)
	if(!(newlevel in (GLOB.tyranidupgradetiers - TYRANID_UPGRADE_INVALID)))
		return FALSE
	hive.upgrade_tyranid(src, upgrade, newlevel)
	upgrade = newlevel
	if(!silent)
		visible_message(span_tyranidnotice("\The [src] begins to twist and contort."), \
		span_tyranidnotice("We begin to twist and contort."))
		do_jitter_animation(1000)
	set_datum(FALSE)
	var/selected_ability_type = selected_ability?.type

	var/list/datum/action/ability/tyranid_action/actions_already_added = mob_abilities
	mob_abilities = list()

	for(var/allowed_action_path in tyranid_caste.actions)
		var/found = FALSE
		for(var/datum/action/ability/tyranid_action/action_already_added AS in actions_already_added)
			if(action_already_added.type == allowed_action_path)
				mob_abilities.Add(action_already_added)
				actions_already_added.Remove(action_already_added)
				found = TRUE
				break
		if(found)
			continue
		var/datum/action/ability/tyranid_action/action = new allowed_action_path()
		if(!SSticker.mode || (SSticker.mode.tyranid_abilities_flags & action.gamemode_flags))
			action.give_action(src)

	for(var/datum/action/ability/tyranid_action/action_already_added AS in actions_already_added)
		action_already_added.remove_action(src)

	SEND_SIGNAL(src, COMSIG_TYRANID_ABILITY_ON_UPGRADE)
	if(selected_ability_type)
		for(var/datum/action/ability/activable/tyranid/activable_ability in actions)
			if(selected_ability_type != activable_ability.type)
				continue
			activable_ability.select()
			break

	if(tyranid_flags & TYRANID_LEADER)
		give_rally_abilities() //Give them back their rally hive ability

	if(current_aura) //Updates pheromone strength
		current_aura.range = 6 + tyranid_caste.aura_strength * 2
		current_aura.strength = tyranid_caste.aura_strength

	switch(upgrade)
		if(TYRANID_UPGRADE_NORMAL)
			switch(tier)
				if(TYRANID_TIER_TWO)
					SSmonitor.stats.normal_T2++
				if(TYRANID_TIER_THREE)
					SSmonitor.stats.normal_T3++
				if(TYRANID_TIER_FOUR)
					SSmonitor.stats.normal_T4++
		if(TYRANID_UPGRADE_PRIMO)
			switch(tier)
				if(TYRANID_TIER_TWO)
					SSmonitor.stats.primo_T2++
				if(TYRANID_TIER_THREE)
					SSmonitor.stats.primo_T3++
				if(TYRANID_TIER_FOUR)
					SSmonitor.stats.primo_T4++
			if(!silent)
				to_chat(src, span_tyranidannounce(tyranid_caste.primordial_message))

	generate_name() //Give them a new name now

	hud_set_plasma()
	med_hud_set_health()

	hud_set_queen_overwatch() //update the upgrade level insignia on our tyranid hud.

	update_spits() //Update spits to new/better ones
	return TRUE

//Tiered spawns.

//-----RUNNER START-----//

/mob/living/carbon/tyranid/runner/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_ONE_THRESHOLD

//-----RUNNER END-----//
//================//
//-----BULL START-----//

/mob/living/carbon/tyranid/bull/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_TWO_THRESHOLD

//-----BULL END-----//
//================//
//-----DRONE START-----//

/mob/living/carbon/tyranid/drone/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_ONE_THRESHOLD

//-----DRONE END-----//
//================//

//----------------------------------------------//
// ERT DRONE START

/mob/living/carbon/tyranid/drone/Corrupted //Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/drone/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/drone/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/drone/Zeta
	hivenumber = TYRANID_HIVE_ZETA

// ERT DRONE START END
//---------------------------------------------//
//-----CARRIER START-----//

/mob/living/carbon/tyranid/carrier
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/carrier/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_TWO_THRESHOLD

//-----CARRIER END-----//
//================//
//----HIVELORD START----//

/mob/living/carbon/tyranid/hivelord
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/hivelord/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_TWO_THRESHOLD

//----HIVELORD END----//
//================//

//================//
//----PRAETORIAN START----//

/mob/living/carbon/tyranid/praetorian
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/praetorian/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

/mob/living/carbon/tyranid/praetorian/dancer/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//----PRAETORIAN END----//
//================//
//----RAVAGER START----//

/mob/living/carbon/tyranid/ravager
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/ravager/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//----RAVAGER END----//
//================//
//RAVAGER ERT START

/mob/living/carbon/tyranid/ravager/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/ravager/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/ravager/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/ravager/Zeta
	hivenumber = TYRANID_HIVE_ZETA

//RAVAGER ERT END
//================//
//----SENTINEL START----//

/mob/living/carbon/tyranid/sentinel
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/sentinel/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_ONE_THRESHOLD

/mob/living/carbon/tyranid/sentinel/retrograde/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_ONE_THRESHOLD

//----SENTINEL END----//
//================//
//-----SPITTER START-----//

/mob/living/carbon/tyranid/spitter
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/spitter/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_TWO_THRESHOLD

//-----SPITTER END-----//
//================//
//SENTINEL ERT START

/mob/living/carbon/tyranid/spitter/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/spitter/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/spitter/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/spitter/Zeta
	hivenumber = TYRANID_HIVE_ZETA

//SENTINEL ERT END
//================//
//----HUNTER START----//

/mob/living/carbon/tyranid/hunter
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/hunter/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_TWO_THRESHOLD

//----HUNTER END----//
//================//
//HUNTER ERT START

/mob/living/carbon/tyranid/hunter/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/hunter/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/hunter/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/hunter/Zeta
	hivenumber = TYRANID_HIVE_ZETA

//HUNTER ERT END
//================//
//----QUEEN START----//

/mob/living/carbon/tyranid/queen
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/queen/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//----QUEEN END----//
//============//
//---KING START---//

/mob/living/carbon/tyranid/king
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/king/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//----KING END----//
//============//
//---CRUSHER START---//

/mob/living/carbon/tyranid/crusher
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/crusher/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//---CRUSHER END---//
//============//
//---GORGER START---//

/mob/living/carbon/tyranid/gorger
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/gorger/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//---GORGER END---//
//============//
//---BOILER START---//

/mob/living/carbon/tyranid/boiler
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/boiler/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//---BOILER END---//
//============//
//---DEFENDER START---//

/mob/living/carbon/tyranid/defender
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/defender/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_ONE_THRESHOLD

//---DEFENDER END---//
//============//
//----WARRIOR START----//

/mob/living/carbon/tyranid/warrior
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/warrior/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_TWO_THRESHOLD

//----WARRIOR END----//
//============//
//----DEFILER START----//

/mob/living/carbon/tyranid/defiler
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/defiler/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//----DEFILER END----//
//============//
//----SHRIKE START----//

/mob/living/carbon/tyranid/shrike
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/shrike/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//----SHRIKE END----//
//============//
//----WRAITH START----//

/mob/living/carbon/tyranid/wraith
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/wraith/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_TWO_THRESHOLD

//----WRAITH END----//
//============//
//----WIDOW START----//

/mob/living/carbon/tyranid/widow
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/widow/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_THREE_THRESHOLD

//----WIDOW END----//
//============//
//----WARLOCK START----//

/mob/living/carbon/tyranid/warlock
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/warlock/primordial
	upgrade = TYRANID_UPGRADE_PRIMO

//----WARLOCK END----//
//============//
//----PUPPETEER START----//
/mob/living/carbon/tyranid/puppeteer
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/puppeteer/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
	upgrade_stored = TIER_TWO_THRESHOLD

//----PUPPETEER END----//
//============//
//----BEHEMOTH START----//

/mob/living/carbon/tyranid/behemoth
	upgrade = TYRANID_UPGRADE_NORMAL

/mob/living/carbon/tyranid/behemoth/primordial
	upgrade = TYRANID_UPGRADE_PRIMO

//----BEHEMOTH END----//
//============//
