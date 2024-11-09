/datum/tyranid_caste/boiler
	caste_name = "Boiler"
	display_name = "Boiler"
	upgrade_name = ""
	caste_desc = "Gross!"

	caste_type_path = /mob/living/carbon/tyranid/boiler

	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "boiler" //used to match appropriate wound overlays

	gib_flick = "gibbed-a-boiler"

	// *** Melee Attacks *** //
	melee_damage = 20

	// *** Speed *** //
	speed = 0.1

	// *** Plasma *** //
	plasma_max = 1000
	plasma_gain = 50

	// *** Health *** //
	max_health = 380

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD

	deevolves_to = /datum/tyranid_caste/spitter

	// *** Darksight *** ///
	conscious_see_in_dark = 20

	// *** Flags *** //
	caste_flags = CASTE_ACID_BLOOD|CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 45, BULLET = 45, LASER = 45, ENERGY = 45, BOMB = 0, BIO = 35, FIRE = 45, ACID = 35)

	// *** Ranged Attack *** //
	spit_delay = 1 SECONDS
	spit_types = list(/datum/ammo/tyranid/boiler_gas, /datum/ammo/tyranid/boiler_gas/corrosive)

	// *** Minimap Icon *** //
	minimap_icon = "boiler"

	// *** Boiler Abilities *** //
	max_ammo = 7
	bomb_strength = 1.3 //Multiplier to the effectiveness of the boiler glob.
	bomb_delay = 32 SECONDS

	acid_spray_duration = 10 SECONDS
	acid_spray_damage = 30
	acid_spray_damage_on_hit = 60
	acid_spray_structure_damage = 45

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/activable/tyranid/corrosive_acid/strong,
		/datum/action/ability/tyranid_action/create_boiler_bomb,
		/datum/action/ability/activable/tyranid/bombard,
		/datum/action/ability/tyranid_action/toggle_long_range,
		/datum/action/ability/tyranid_action/toggle_bomb,
		/datum/action/ability/activable/tyranid/spray_acid/line/boiler,
		/datum/action/ability/activable/tyranid/acid_shroud,
	)

/datum/tyranid_caste/boiler/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/boiler/primordial
	upgrade_name = "Primordial"
	caste_desc = "A horrendously effective alien siege engine."
	upgrade = TYRANID_UPGRADE_PRIMO
	primordial_message = "We have refined the art of bombardement to perfection. End them before they can utter a desperate plea."

	// *** Ranged Attack *** //
	spit_types = list(/datum/ammo/tyranid/boiler_gas, /datum/ammo/tyranid/boiler_gas/lance, /datum/ammo/tyranid/boiler_gas/corrosive, /datum/ammo/tyranid/boiler_gas/corrosive/lance)

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/tyranid_action/place_acidwell,
		/datum/action/ability/activable/tyranid/corrosive_acid/strong,
		/datum/action/ability/tyranid_action/create_boiler_bomb,
		/datum/action/ability/activable/tyranid/bombard,
		/datum/action/ability/tyranid_action/toggle_long_range,
		/datum/action/ability/tyranid_action/toggle_bomb,
		/datum/action/ability/activable/tyranid/spray_acid/line/boiler,
		/datum/action/ability/activable/tyranid/acid_shroud,
	)
