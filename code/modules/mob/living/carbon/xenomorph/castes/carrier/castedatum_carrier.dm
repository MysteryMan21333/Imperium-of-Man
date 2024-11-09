/datum/tyranid_caste/carrier
	caste_name = "Carrier"
	display_name = "Carrier"
	upgrade_name = ""
	caste_desc = "A carrier of huggies."

	caste_type_path = /mob/living/carbon/tyranid/carrier

	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "carrier" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 22

	// *** Speed *** //
	speed = -0.2

	// *** Plasma *** //
	plasma_max = 1000
	plasma_gain = 50

	// *** Health *** //
	max_health = 425

	// *** Evolution *** //
	evolution_threshold = 225
	upgrade_threshold = TIER_TWO_THRESHOLD

	deevolves_to = /datum/tyranid_caste/drone

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_hold_eggs = CAN_HOLD_ONE_HAND
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 0, BIO = 5, FIRE = 25, ACID = 5)

	// *** Pheromones *** //
	aura_strength = 2.5

	// *** Minimap Icon *** //
	minimap_icon = "carrier"

	// *** Carrier Abilities *** //
	huggers_max = 8
	hugger_delay = 1.25 SECONDS

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/throw_hugger,
		/datum/action/ability/activable/tyranid/call_younger,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/tyranid_action/place_trap,
		/datum/action/ability/tyranid_action/spawn_hugger,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/tyranid_action/carrier_panic,
		/datum/action/ability/tyranid_action/choose_hugger_type,
	)

/datum/tyranid_caste/carrier/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/carrier/primodial
	upgrade_name = "Primordial"
	caste_desc = "It's literally crawling with 11 huggers."
	upgrade = TYRANID_UPGRADE_PRIMO
	primordial_message = "Not one tall will be left uninfected."

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/throw_hugger,
		/datum/action/ability/activable/tyranid/call_younger,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/tyranid_action/place_trap,
		/datum/action/ability/tyranid_action/spawn_hugger,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/tyranid_action/carrier_panic,
		/datum/action/ability/tyranid_action/choose_hugger_type,
		/datum/action/ability/tyranid_action/build_hugger_turret,
	)
