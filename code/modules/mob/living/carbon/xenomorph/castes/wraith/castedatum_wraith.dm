/datum/tyranid_caste/wraith
	caste_name = "Wraith"
	display_name = "Wraith"
	upgrade_name = ""
	caste_desc = "A strange tyranid that utilizes its psychic powers to move out of phase with reality."
	caste_type_path = /mob/living/carbon/tyranid/wraith
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "wraith" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 24

	// *** Speed *** //
	speed = -1.1

	// *** Plasma *** //
	plasma_max = 400
	plasma_gain = 35

	// *** Health *** //
	max_health = 340

	// *** Evolution *** //
	evolution_threshold = 225
	upgrade_threshold = TIER_TWO_THRESHOLD

	deevolves_to = /datum/tyranid_caste/runner

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = list(TRAIT_CAN_VENTCRAWL)

	// *** Defense *** //
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 0, BIO = 20, FIRE = 30, ACID = 20)

	// *** Minimap Icon *** //
	minimap_icon = "wraith"

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/blink,
		/datum/action/ability/activable/tyranid/banish,
		/datum/action/ability/tyranid_action/recall,
		/datum/action/ability/activable/tyranid/rewind,
		/datum/action/ability/tyranid_action/portal,
	)

/datum/tyranid_caste/wraith/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/wraith/primordial
	upgrade_name = "Primordial"
	caste_desc = "A tyranid that has perfected the manipulation of space and time. Its movements appear quick and distorted."
	primordial_message = "Mastery is achieved when \'telling time\' becomes \'telling time what to do\'."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/blink,
		/datum/action/ability/activable/tyranid/banish,
		/datum/action/ability/tyranid_action/recall,
		/datum/action/ability/tyranid_action/portal,
		/datum/action/ability/activable/tyranid/rewind,
		/datum/action/ability/tyranid_action/timestop,
	)

