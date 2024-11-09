/datum/tyranid_caste/defender
	caste_name = "Defender"
	display_name = "Defender"
	upgrade_name = ""
	caste_desc = "An alien with an armored crest. It looks very tough."

	caste_type_path = /mob/living/carbon/tyranid/defender

	tier = TYRANID_TIER_ONE
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "defender" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 22

	// *** Speed *** //
	speed = -0.5

	// *** Plasma *** //
	plasma_max = 200
	plasma_gain = 20

	// *** Health *** //
	max_health = 420

	// *** Evolution *** //
	evolution_threshold = 100
	upgrade_threshold = TIER_ONE_THRESHOLD

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 45, BULLET = 45, LASER = 45, ENERGY = 45, BOMB = 30, BIO = 30, FIRE = 40, ACID = 30)

	// *** Minimap Icon *** //
	minimap_icon = "defender"

	// *** Defender Abilities *** //
	crest_defense_armor = 30
	crest_defense_slowdown = 0.8
	fortify_armor = 50

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/tyranid_action/toggle_crest_defense,
		/datum/action/ability/tyranid_action/fortify,
		/datum/action/ability/activable/tyranid/charge/forward_charge,
		/datum/action/ability/tyranid_action/tail_sweep,
		/datum/action/ability/tyranid_action/regenerate_skin,
	)

/datum/tyranid_caste/defender/ancient
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/defender/primordial
	upgrade_name = "Primordial"
	caste_desc = "Alien with an incredibly tough and armored head crest able to endure even the strongest hits."
	upgrade = TYRANID_UPGRADE_PRIMO
	primordial_message = "We are the aegis of the hive. Let nothing pierce our guard."

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/tyranid_action/toggle_crest_defense,
		/datum/action/ability/tyranid_action/fortify,
		/datum/action/ability/activable/tyranid/charge/forward_charge,
		/datum/action/ability/tyranid_action/tail_sweep,
		/datum/action/ability/tyranid_action/regenerate_skin,
		/datum/action/ability/tyranid_action/centrifugal_force,
	)
