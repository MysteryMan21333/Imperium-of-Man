/datum/tyranid_caste/shrike
	caste_name = "Shrike"
	display_name = "Shrike"
	upgrade_name = ""
	caste_desc = "A psychically unstable tyranid. The Shrike controls the hive when there's no Queen and acts as its successor when there is."
	job_type = /datum/job/tyranid/queen
	caste_type_path = /mob/living/carbon/tyranid/shrike

	tier = TYRANID_TIER_FOUR
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "shrike" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 25

	// *** Speed *** //
	speed = -0.4

	// *** Plasma *** //
	plasma_max = 925
	plasma_gain = 60

	// *** Health *** //
	max_health = 500

	// *** Evolution *** //
	// The only evolution path does not require threshold
	// evolution_threshold = 225
	maximum_active_caste = 1
	upgrade_threshold = TIER_TWO_THRESHOLD

	deevolves_to = /datum/tyranid_caste/drone

	// *** Flags *** //
	caste_flags = CASTE_IS_INTELLIGENT|CASTE_IS_STRONG|CASTE_IS_BUILDER|CASTE_INSTANT_EVOLUTION|CASTE_EVOLUTION_ALLOWED|CASTE_LEADER_TYPE
	can_hold_eggs = CAN_HOLD_TWO_HANDS
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER|CASTE_CAN_CORRUPT_GENERATOR
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 45, BULLET = 45, LASER = 45, ENERGY = 45, BOMB = 20, BIO = 25, FIRE = 45, ACID = 20)

	// *** Pheromones *** //
	aura_strength = 3 //The Shrike's aura is decent.

	// *** Minimap Icon *** //
	minimap_icon = "tyranidshrike"

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/activable/tyranid/neurotox_sting/ozelomelyn,
		/datum/action/ability/tyranid_action/call_of_the_burrowed,
		/datum/action/ability/activable/tyranid/secrete_resin,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/activable/tyranid/corrosive_acid,
		/datum/action/ability/activable/tyranid/psychic_cure,
		/datum/action/ability/activable/tyranid/transfer_plasma/drone,
		/datum/action/ability/tyranid_action/psychic_whisper,
		/datum/action/ability/activable/tyranid/psychic_fling,
		/datum/action/ability/activable/tyranid/unrelenting_force,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/tyranid_action/hive_message,
		/datum/action/ability/tyranid_action/rally_hive,
		/datum/action/ability/tyranid_action/rally_minion,
		/datum/action/ability/tyranid_action/blessing_menu,
	)

/datum/tyranid_caste/shrike/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/shrike/primordial
	upgrade_name = "Primordial"
	caste_desc = "The unleashed repository of the hive's psychic power."
	primordial_message = "We are the unbridled psychic power of the hive. Throw our enemies to their doom."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/activable/tyranid/neurotox_sting/ozelomelyn,
		/datum/action/ability/tyranid_action/call_of_the_burrowed,
		/datum/action/ability/activable/tyranid/secrete_resin,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/activable/tyranid/corrosive_acid,
		/datum/action/ability/activable/tyranid/psychic_cure,
		/datum/action/ability/activable/tyranid/transfer_plasma/drone,
		/datum/action/ability/tyranid_action/sow,
		/datum/action/ability/tyranid_action/psychic_whisper,
		/datum/action/ability/activable/tyranid/psychic_fling,
		/datum/action/ability/activable/tyranid/unrelenting_force,
		/datum/action/ability/tyranid_action/pheromones,
		/datum/action/ability/tyranid_action/pheromones/emit_recovery,
		/datum/action/ability/tyranid_action/pheromones/emit_warding,
		/datum/action/ability/tyranid_action/pheromones/emit_frenzy,
		/datum/action/ability/tyranid_action/hive_message,
		/datum/action/ability/tyranid_action/rally_hive,
		/datum/action/ability/tyranid_action/rally_minion,
		/datum/action/ability/tyranid_action/blessing_menu,
		/datum/action/ability/activable/tyranid/psychic_vortex,
	)
