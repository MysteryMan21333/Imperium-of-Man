/mob/living/carbon/tyranid/UnarmedAttack(atom/A, has_proximity, modifiers)
	if(lying_angle)
		return FALSE
	if(isclosedturf(get_turf(src)) && !iswallturf(A))	//If we are on a closed turf (e.g. in a wall) we can't attack anything, except walls (or well, resin walls really) so we can't make ourselves be stuck.
		balloon_alert(src, "Cannot reach")
		return FALSE
	if(!(isopenturf(A) || istype(A, /obj/alien/weeds))) //We don't care about open turfs; they don't trigger our melee click cooldown
		changeNext_move(tyranid_caste ? tyranid_caste.attack_delay : CLICK_CD_MELEE)
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		return

	var/atom/S = A.handle_barriers(src)
	S.attack_alien(src, tyranid_caste.melee_damage * tyranid_melee_damage_modifier, isrightclick = islist(modifiers) ? modifiers["right"] : FALSE)
	GLOB.round_statistics.tyranid_unarmed_attacks++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "tyranid_unarmed_attacks")


/atom/proc/attack_alien(mob/living/carbon/tyranid/tyranid_attacker, damage_amount = tyranid_attacker.tyranid_caste.melee_damage, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = tyranid_attacker.tyranid_caste.melee_ap, isrightclick = FALSE)
	return


/mob/living/carbon/tyranid/larva/UnarmedAttack(atom/A, has_proximity, modifiers)
	if(lying_angle)
		return FALSE
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		return FALSE

	A.attack_larva(src)

/atom/proc/attack_larva(mob/living/carbon/tyranid/larva/L)
	return



/mob/living/carbon/tyranid/hivemind/UnarmedAttack(atom/A, has_proximity, modifiers)
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		return
	A.attack_hivemind(src)

/atom/proc/attack_hivemind(mob/living/carbon/tyranid/hivemind/attacker)
	return
