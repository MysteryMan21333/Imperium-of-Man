/datum/tyranid_caste/crusher
	caste_name = "Crusher"
	display_name = "Crusher"
	upgrade_name = ""
	caste_desc = "A huge tanky tyranid."
	caste_type_path = /mob/living/carbon/tyranid/crusher

	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "crusher" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 25
	attack_delay = 8

	// *** Speed *** //
	speed = -0.1

	// *** Plasma *** //
	plasma_max = 520
	plasma_gain = 40

	// *** Health *** //
	max_health = 485

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD

	deevolves_to = /datum/tyranid_caste/bull

	// *** Flags *** //
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = list(TRAIT_STOPS_TANK_COLLISION)

	// *** Defense *** //
	soft_armor = list(MELEE = 90, BULLET = 75, LASER = 75, ENERGY = 75, BOMB = 130, BIO = 100, FIRE = 50, ACID = 100)

	// *** Sunder *** //
	sunder_multiplier = 0.7

	// *** Minimap Icon *** //
	minimap_icon = "crusher"

	// *** Crusher Abilities *** //
	stomp_damage = 60
	crest_toss_distance = 6

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/stomp,
		/datum/action/ability/tyranid_action/ready_charge,
		/datum/action/ability/activable/tyranid/cresttoss,
	)

/datum/tyranid_caste/crusher/on_caste_applied(mob/tyranid)
	. = ..()
	tyranid.AddElement(/datum/element/ridable, /datum/component/riding/creature/crusher)
	tyranid.RegisterSignal(tyranid, COMSIG_GRAB_SELF_ATTACK, TYPE_PROC_REF(/mob/living/carbon/tyranid, grabbed_self_attack))

/datum/tyranid_caste/crusher/on_caste_removed(mob/tyranid)
	. = ..()
	tyranid.RemoveElement(/datum/element/ridable, /datum/component/riding/creature/crusher)
	tyranid.UnregisterSignal(tyranid, COMSIG_GRAB_SELF_ATTACK)

/datum/tyranid_caste/crusher/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/crusher/primordial
	upgrade_name = "Primordial"
	caste_desc = "Behemoth of the hive. Nothing will remain in its way"
	primordial_message = "We are an unstoppable force. Crush. Kill. Destroy."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/stomp,
		/datum/action/ability/tyranid_action/ready_charge,
		/datum/action/ability/activable/tyranid/cresttoss,
		/datum/action/ability/activable/tyranid/advance,
	)
