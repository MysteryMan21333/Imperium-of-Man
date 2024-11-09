/datum/tyranid_caste/warrior
	caste_name = "Warrior"
	display_name = "Warrior"
	upgrade_name = ""
	caste_desc = "A powerful front line combatant."
	caste_type_path = /mob/living/carbon/tyranid/warrior
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "warrior" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 25

	// *** Speed *** //
	speed = -0.4

	// *** Plasma *** //
	plasma_max = 150
	plasma_gain = 15

	// *** Health *** //
	max_health = 400

	// *** Sunder *** //
	sunder_multiplier = 0.9

	// *** Evolution *** //
	evolution_threshold = 225
	upgrade_threshold = TIER_TWO_THRESHOLD

	deevolves_to = /datum/tyranid_caste/defender

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_IS_STRONG
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 60, BOMB = 30, BIO = 50, FIRE = 55, ACID = 50)

	// *** Minimap Icon *** //
	minimap_icon = "warrior"

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/tyranid_action/toggle_agility,
		/datum/action/ability/activable/tyranid/warrior/lunge,
		/datum/action/ability/activable/tyranid/warrior/fling,
		/datum/action/ability/activable/tyranid/warrior/grapple_toss,
		/datum/action/ability/activable/tyranid/warrior/punch,
	)

/datum/tyranid_caste/warrior/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/warrior/primordial
	upgrade_name = "Primordial"
	caste_desc = "A champion of the hive, methodically shatters its opponents with punches rather than slashes."
	primordial_message = "Our rhythm is unmatched and our strikes lethal, no single foe can stand against us."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/tyranid_action/empower,
		/datum/action/ability/tyranid_action/toggle_agility,
		/datum/action/ability/activable/tyranid/warrior/lunge,
		/datum/action/ability/activable/tyranid/warrior/fling,
		/datum/action/ability/activable/tyranid/warrior/grapple_toss,
		/datum/action/ability/activable/tyranid/warrior/punch,
		/datum/action/ability/activable/tyranid/warrior/punch/flurry,
	)
