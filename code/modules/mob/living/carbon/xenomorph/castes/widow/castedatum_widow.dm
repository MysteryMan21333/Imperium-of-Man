/datum/tyranid_caste/widow
	caste_name = "Widow"
	display_name = "Widow"
	upgrade_name = ""
	caste_desc = "You don't think you've seen a tarantula this giant before."
	caste_type_path = /mob/living/carbon/tyranid/widow

	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "widow"

	// *** Melee Attacks *** //
	melee_damage = 20

	// *** Speed *** //
	speed = -0.5

	// *** Plasma *** //
	plasma_max = 600
	plasma_gain = 55

	// *** Health *** //
	max_health = 450

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD

	deevolves_to = /datum/tyranid_caste/puppeteer

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_IS_BUILDER
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 15, BIO = 10, FIRE = 15, ACID = 10)

	// *** Minimap Icon *** //
	minimap_icon = "widow"

	// *** Widow Abilities *** //
	max_spiderlings = 5

	// *** Abilities *** ///
	resin_max_range = 1 // Widow can place resin structures from 1 tile away

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/secrete_resin/widow,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/activable/tyranid/web_spit,
		/datum/action/ability/tyranid_action/burrow,
		/datum/action/ability/activable/tyranid/leash_ball,
		/datum/action/ability/tyranid_action/create_spiderling,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/tyranid_action/attach_spiderlings,
		/datum/action/ability/activable/tyranid/cannibalise,
		/datum/action/ability/activable/tyranid/spiderling_mark,
	)

/datum/tyranid_caste/widow/on_caste_applied(mob/tyranid)
	. = ..()
	tyranid.AddElement(/datum/element/wall_speedup, WIDOW_SPEED_BONUS)
	tyranid.AddElement(/datum/element/ridable, /datum/component/riding/creature/widow)

/datum/tyranid_caste/widow/on_caste_removed(mob/tyranid)
	. = ..()
	tyranid.RemoveElement(/datum/element/wall_speedup, WIDOW_SPEED_BONUS)
	tyranid.RemoveElement(/datum/element/ridable, /datum/component/riding/creature/widow)

/datum/tyranid_caste/widow/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/widow/primordial
	upgrade_name = "Primordial"
	caste_desc = "At times, life is just like a web. You fall, and a spider called accident, at the center, takes you to hell."
	primordial_message = "We weave the threads of fate that our victims life hangs from."
	upgrade = TYRANID_UPGRADE_PRIMO

	// *** Abilities *** ///
	resin_max_range = 1 //Widow can place resin structures from 1 tile away

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/cocoon,
		/datum/action/ability/activable/tyranid/plant_weeds,
		/datum/action/ability/activable/tyranid/secrete_resin/widow,
		/datum/action/ability/activable/tyranid/secrete_special_resin,
		/datum/action/ability/activable/tyranid/web_spit,
		/datum/action/ability/tyranid_action/burrow,
		/datum/action/ability/activable/tyranid/leash_ball,
		/datum/action/ability/tyranid_action/create_spiderling,
		/datum/action/ability/tyranid_action/lay_egg,
		/datum/action/ability/tyranid_action/attach_spiderlings,
		/datum/action/ability/activable/tyranid/cannibalise,
		/datum/action/ability/activable/tyranid/spiderling_mark,
		/datum/action/ability/tyranid_action/sow,
		/datum/action/ability/activable/tyranid/web_hook,
	)
