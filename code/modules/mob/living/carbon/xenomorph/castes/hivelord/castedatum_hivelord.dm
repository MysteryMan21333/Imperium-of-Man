/datum/tyranid_caste/hivelord
	caste_name = "Hivelord"
	display_name = "Hivelord"
	upgrade_name = ""
	caste_desc = "A builder of REALLY BIG hives."
	caste_type_path = /mob/living/carbon/tyranid/hivelord
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "hivelord" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 20

	// *** Speed *** //
	speed = 0.1

	// *** Plasma *** //
	plasma_max = 2400
	plasma_gain = 80
	plasma_regen_limit = 0.5
	plasma_icon_state = "hivelord_plasma"

	// *** Health *** //
	max_health = 410


	// *** Evolution *** //
	evolution_threshold = 225
	upgrade_threshold = TIER_TWO_THRESHOLD

	deevolves_to = /datum/tyranid_caste/drone

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_IS_BUILDER
	can_hold_eggs = CAN_HOLD_TWO_HANDS
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_HOLD_JELLY
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 35, BULLET = 35, LASER = 35, ENERGY = 35, BOMB = 0, BIO = 20, FIRE = 30, ACID = 20)

	// *** Ranged Attack *** //
	spit_delay = 1.3 SECONDS
	spit_types = list(/datum/ammo/tyranid/sticky)

	// *** Pheromones *** //
	aura_strength = 3 //Hivelord's aura is not extremely strong, but better than Drones.

	// *** Minimap Icon *** //
	minimap_icon = "hivelord"

	// *** Abilities *** //

	resin_max_range = 1 //Hivelord can place resin structures from 1 tile away

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/healing_infusion,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/activable/tyranid/secrete_resin/hivelord,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/tyranid_action/blessing_menu,
		/datum/action/ability/activable/tyranid/transfer_plasma/improved,
		/datum/action/ability/activable/tyranid/corrosive_acid,
		/datum/action/ability/tyranid_action/build_tunnel,
		/datum/action/ability/tyranid_action/toggle_speed,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/activable/tyranid/tyranid_spit,
		/datum/action/ability/tyranid_action/create_jelly,
		/datum/action/ability/tyranid_action/place_jelly_pod,
		/datum/action/ability/activable/tyranid/recycle,
	)

/datum/tyranid_caste/hivelord/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/hivelord/primordial
	upgrade_name = "Primordial"
	caste_desc = "Ultimate builder of the hive. It seems twitchy and is constantly building something"
	primordial_message = "We are the master architect of the hive. Let the world be covered in resin."
	upgrade = TYRANID_UPGRADE_PRIMO

	spit_types = list(/datum/ammo/tyranid/sticky, /datum/ammo/tyranid/sticky/globe)

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/healing_infusion,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/activable/tyranid/secrete_resin/hivelord,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/tyranid_action/blessing_menu,
		/datum/action/ability/activable/tyranid/transfer_plasma/improved,
		/datum/action/ability/activable/tyranid/corrosive_acid/strong,
		/datum/action/ability/tyranid_action/sow,
		/datum/action/ability/tyranid_action/build_tunnel,
		/datum/action/ability/tyranid_action/toggle_speed,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/activable/tyranid/tyranid_spit,
		/datum/action/ability/tyranid_action/create_jelly,
		/datum/action/ability/tyranid_action/place_jelly_pod,
		/datum/action/ability/activable/tyranid/recycle,
	)
