/datum/action/ability/activable/tyranid/feed
	name = "Feed"
	action_icon_state = "lunge"
	desc = "Assault an organic, restoring health through the use of the their biomass."
	ability_cost = 0
	cooldown_duration = 35 SECONDS
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/activable/tyranid/feed/use_ability(mob/living/carbon/human/target_human)
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	owner_tyranid.face_atom(target_human)
	owner_tyranid.do_attack_animation(target_human, ATTACK_EFFECT_REDSLASH)
	owner_tyranid.visible_message(target_human, span_danger("[owner_tyranid] tears into [target_human]!"))
	playsound(target_human, SFX_ALIEN_CLAW_FLESH, 25, TRUE)
	target_human.emote("scream")
	target_human.apply_damage(damage = 25, damagetype = BRUTE, def_zone = BODY_ZONE_CHEST, blocked = 0, sharp = TRUE, edge = FALSE, updating_health = TRUE)
	var/amount = 15 //heal tyranid damage needs a variable not a number
	HEAL_TYRANID_DAMAGE(owner_tyranid, amount, FALSE)
	add_cooldown()

/datum/action/ability/activable/tyranid/feed/can_use_ability(mob/living/target, silent = FALSE, override_flags)
	. = ..()
	if(!ishuman(target))
		return FALSE
	if(!owner.Adjacent(target))
		return FALSE
