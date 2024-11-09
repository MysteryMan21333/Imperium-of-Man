/datum/tyranid_caste/hivemind
	caste_name = "Hivemind"
	display_name = "Hivemind"
	upgrade_name = ""
	caste_desc = "The mind of the hive"
	caste_type_path = /mob/living/carbon/tyranid/hivemind
	tier = TYRANID_TIER_ZERO
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = ""
	// *** Melee Attacks *** //
	melee_damage = 0

	// *** Speed *** //
	speed = 0

	// *** Plasma *** //
	plasma_max = 600 //  75 is the cost of plant_weeds
	plasma_gain = 60

	// *** Health *** //
	max_health = 100

	maximum_active_caste = 1
	// *** Flags *** //
	caste_flags = CASTE_INNATE_PLASMA_REGEN|CASTE_FIRE_IMMUNE|CASTE_IS_BUILDER|CASTE_DO_NOT_ALERT_LOW_LIFE
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

	// *** Minimap Icon *** //
	minimap_icon = "hivemind"

	// *** Ranged Attack *** //
	spit_delay = 0 SECONDS
	spit_types = list()

	aura_strength = 0

	// *** Abilities *** //

	resin_max_range = 4 //Hivemind can place resin structures from 4 tiles away

	actions = list(
		/datum/action/ability/tyranid_action/watch_tyranid/hivemind,
		/datum/action/ability/tyranid_action/change_form,
		/datum/action/ability/tyranid_action/return_to_core,
		/datum/action/ability/tyranid_action/teleport,
		/datum/action/ability/tyranid_action/rally_hive/hivemind,
		/datum/action/ability/activable/tyranid/command_minions,
		/datum/action/ability/tyranid_action/psychic_whisper,
		/datum/action/ability/activable/tyranid/plant_weeds/ranged,
		/datum/action/ability/activable/tyranid/psychic_cure/queen_give_heal/hivemind,
		/datum/action/ability/activable/tyranid/transfer_plasma/hivemind,
		/datum/action/ability/tyranid_action/pheromones/hivemind,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/activable/tyranid/secrete_resin/hivemind,
		/datum/action/ability/activable/tyranid/secrete_special_resin/hivemind,
	)

/datum/tyranid_caste/hivemind/on_caste_applied(mob/tyranid)
	return

/datum/tyranid_caste/hivemind/on_caste_removed(mob/tyranid)
	return

/datum/tyranid_caste/hivemind/hivemind_manifestation
	caste_desc = "The manifestation of the hivemind"
	wound_type = "hivemind"

	upgrade = TYRANID_UPGRADE_MANIFESTATION

	// *** Flags *** //
	caste_flags = CASTE_IS_BUILDER|CASTE_FIRE_IMMUNE

	aura_strength = 4 //Good pheros

	speed = 1.5
