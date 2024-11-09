/datum/tyranid_caste/king
	caste_name = "King"
	display_name = "King"
	upgrade_name = ""
	caste_type_path = /mob/living/carbon/tyranid/king
	caste_desc = "A primordial creature, evolved to smash the hardiest of defences and hunt the hardiest of prey."

	tier = TYRANID_TIER_FOUR
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "king" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 33

	// *** Speed *** //
	speed = -0.1

	// *** Plasma *** //
	plasma_max = 1200
	plasma_gain = 90

	// *** Health *** //
	max_health = 700

	// *** Sunder *** //
	sunder_multiplier = 0.8

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD
	maximum_active_caste = 1
	evolve_min_tyranids = 12
	death_evolution_delay = 7 MINUTES

	// *** Flags *** //
	caste_flags = CASTE_IS_INTELLIGENT|CASTE_STAGGER_RESISTANT|CASTE_LEADER_TYPE|CASTE_INSTANT_EVOLUTION|CASTE_HAS_WOUND_MASK
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_CORRUPT_GENERATOR
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 65, BOMB = 100, BIO = 60, FIRE = 100, ACID = 60)

	// *** Pheromones *** //
	aura_strength = 4.5

	minimap_icon = "tyranidking"

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/tyranid_action/call_of_the_burrowed,
		/datum/action/ability/activable/tyranid/corrosive_acid/strong,
		/datum/action/ability/activable/tyranid/nightfall,
		/datum/action/ability/tyranid_action/petrify,
		/datum/action/ability/activable/tyranid/off_guard,
		/datum/action/ability/activable/tyranid/shattering_roar,
		/datum/action/ability/tyranid_action/psychic_summon,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/tyranid_action/hive_message,
		/datum/action/ability/tyranid_action/rally_hive,
		/datum/action/ability/tyranid_action/rally_minion,
		/datum/action/ability/tyranid_action/blessing_menu,
	)


/datum/tyranid_caste/king/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/king/primordial
	upgrade_name = "Primordial"
	caste_desc = "An avatar of death. Running won't help you now."
	primordial_message = "Death cannot create, but you definitely know how to destroy."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/tyranid_action/call_of_the_burrowed,
		/datum/action/ability/activable/tyranid/corrosive_acid/strong,
		/datum/action/ability/activable/tyranid/nightfall,
		/datum/action/ability/tyranid_action/petrify,
		/datum/action/ability/activable/tyranid/off_guard,
		/datum/action/ability/activable/tyranid/shattering_roar,
		/datum/action/ability/tyranid_action/zero_form_beam,
		/datum/action/ability/tyranid_action/psychic_summon,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/tyranid_action/hive_message,
		/datum/action/ability/tyranid_action/rally_hive,
		/datum/action/ability/tyranid_action/rally_minion,
		/datum/action/ability/tyranid_action/blessing_menu,
	)
