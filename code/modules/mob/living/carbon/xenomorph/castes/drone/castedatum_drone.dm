/datum/tyranid_caste/drone
	caste_name = "Drone"
	display_name = "Drone"
	upgrade_name = ""
	caste_desc = "A builder of hives. Only drones may evolve into Shrikes."
	caste_type_path = /mob/living/carbon/tyranid/drone

	tier = TYRANID_TIER_ONE
	upgrade = TYRANID_UPGRADE_BASETYPE

	gib_anim = "gibbed-a-small-corpse"
	gib_flick = "gibbed-a-small"

	// *** Melee Attacks *** //
	melee_damage = 19

	// *** Speed *** //
	speed = -1.1
	weeds_speed_mod = -0.4

	// *** Plasma *** //
	plasma_max = 1000
	plasma_gain = 50

	// *** Health *** //
	max_health = 380

	// *** Evolution *** //
	evolution_threshold = 100
	upgrade_threshold = TIER_ONE_THRESHOLD

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_IS_BUILDER
	can_hold_eggs = CAN_HOLD_TWO_HANDS
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_HOLD_JELLY|CASTE_CAN_RIDE_CRUSHER
	caste_traits = list(TRAIT_CAN_VENTCRAWL)

	// *** Defense *** //
	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 0, BIO = 15, FIRE = 30, ACID = 15)

	// *** Pheromones *** //
	aura_strength = 2 //Drone's aura is the weakest.

	// *** Minimap Icon *** //
	minimap_icon = "drone"

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/secrete_resin,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/activable/tyranid/essence_link,
		/datum/action/ability/activable/tyranid/psychic_cure/acidic_salve,
		/datum/action/ability/activable/tyranid/transfer_plasma/drone,
		/datum/action/ability/activable/tyranid/corrosive_acid/drone,
		/datum/action/ability/tyranid_action/create_jelly/slow,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/activable/tyranid/recycle,
	)

/datum/tyranid_caste/drone/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/drone/primordial
	upgrade_name = "Primordial"
	caste_desc = "The perfect worker."
	primordial_message = "We shall build wonders with our claws. Glory to the hive."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/secrete_resin,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/activable/tyranid/essence_link,
		/datum/action/ability/activable/tyranid/psychic_cure/acidic_salve,
		/datum/action/ability/activable/tyranid/transfer_plasma/drone,
		/datum/action/ability/tyranid_action/sow,
		/datum/action/ability/tyranid_action/enhancement,
		/datum/action/ability/activable/tyranid/corrosive_acid/drone,
		/datum/action/ability/tyranid_action/create_jelly/slow,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/activable/tyranid/recycle,
	)
