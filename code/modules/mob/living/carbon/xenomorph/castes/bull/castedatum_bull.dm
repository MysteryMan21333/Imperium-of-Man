/datum/tyranid_caste/bull
	caste_name = "Bull"
	display_name = "Bull"
	upgrade_name = ""
	caste_desc = "A well defended hit-and-runner."
	caste_type_path = /mob/living/carbon/tyranid/bull
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "bull" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 24

	// *** Speed *** //
	speed = -0.8

	// *** Plasma *** //
	plasma_max = 340 //High plasma is need for charging
	plasma_gain = 24

	// *** Health *** //
	max_health = 450

	// *** Sunder *** //
	sunder_multiplier = 0.9

	// *** Evolution *** //
	evolution_threshold = 225
	upgrade_threshold = TIER_TWO_THRESHOLD

	deevolves_to = /datum/tyranid_caste/runner

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 50, BULLET = 55, LASER = 55, ENERGY = 55, BOMB = 20, BIO = 35, FIRE = 50, ACID = 35)

	// *** Minimap Icon *** //
	minimap_icon = "bull"

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/tyranid_action/ready_charge/bull_charge,
		/datum/action/ability/activable/tyranid/bull_charge,
		/datum/action/ability/activable/tyranid/bull_charge/headbutt,
		/datum/action/ability/activable/tyranid/bull_charge/gore,
		/datum/action/ability/tyranid_action/toggle_long_range/bull,
	)

/datum/tyranid_caste/bull/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/bull/primordial
	upgrade_name = "Primordial"
	caste_desc = "Bloodthirsty horned devil of the hive. Stay away from its path."
	primordial_message = "We are the spearhead of the hive. Run them all down."
	upgrade = TYRANID_UPGRADE_PRIMO
