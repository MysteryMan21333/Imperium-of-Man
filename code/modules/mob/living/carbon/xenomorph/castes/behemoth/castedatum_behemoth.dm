/datum/tyranid_caste/behemoth
	caste_name = "Behemoth"
	display_name = "Behemoth"
	upgrade_name = ""
	caste_desc = "Behemoths are known to like rocks. Perhaps we should give them one!"
	caste_type_path = /mob/living/carbon/tyranid/behemoth
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "behemoth"

	// *** Melee Attacks *** //
	melee_damage = 23

	// *** Speed *** //
	speed = -0.5
	weeds_speed_mod = -0.2

	// *** Plasma *** //
	plasma_max = 300
	plasma_gain = 30

	// *** Health *** //
	max_health = 700

	// *** Sunder *** //
	sunder_multiplier = 0.8

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD

	deevolves_to = /datum/tyranid_caste/bull

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_IS_STRONG|CASTE_STAGGER_RESISTANT
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 60, BIO = 50, FIRE = 50, ACID = 50)
	hard_armor = list(MELEE = 10, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

	// *** Minimap Icon *** //
	minimap_icon = "behemoth"

	// *** Abilities *** ///
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/tyranid_action/ready_charge/behemoth_roll,
		/datum/action/ability/activable/tyranid/landslide,
		/datum/action/ability/activable/tyranid/earth_riser,
		/datum/action/ability/tyranid_action/seismic_fracture,
	)

/datum/tyranid_caste/behemoth/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/behemoth/primordial
	upgrade_name = "Primordial"
	primordial_message = "In the ancient embrace of the earth, we have honed our art to perfection. Our might will crush the feeble pleas of our enemies before they can escape their lips."
	upgrade = TYRANID_UPGRADE_PRIMO

	// *** Wrath *** //
	wrath_max = 650

	// *** Abilities *** ///
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/tyranid_action/ready_charge/behemoth_roll,
		/datum/action/ability/activable/tyranid/landslide,
		/datum/action/ability/activable/tyranid/earth_riser,
		/datum/action/ability/tyranid_action/seismic_fracture,
		/datum/action/ability/tyranid_action/primal_wrath,
	)

/datum/tyranid_caste/behemoth/on_caste_applied(mob/tyranid)
	. = ..()
	tyranid.AddElement(/datum/element/ridable, /datum/component/riding/creature/crusher) // we use the same riding element as crusher
	tyranid.RegisterSignal(tyranid, COMSIG_GRAB_SELF_ATTACK, TYPE_PROC_REF(/mob/living/carbon/tyranid, grabbed_self_attack))

/datum/tyranid_caste/behemoth/on_caste_removed(mob/tyranid)
	. = ..()
	tyranid.RemoveElement(/datum/element/ridable, /datum/component/riding/creature/crusher)
	tyranid.UnregisterSignal(tyranid, COMSIG_GRAB_SELF_ATTACK)
