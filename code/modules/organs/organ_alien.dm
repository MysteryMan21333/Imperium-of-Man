//TYRANID ORGANS
/datum/internal_organ/tyranids/eggsac
	name = "egg sac"
	parent_limb = "groin"
	removed_type = /obj/item/organ/tyranids/eggsac

/datum/internal_organ/tyranids/plasmavessel
	name = "plasma vessel"
	parent_limb = "chest"
	removed_type = /obj/item/organ/tyranids/plasmavessel
	var/stored_plasma = 0
	var/max_plasma = 500

/datum/internal_organ/tyranids/plasmavessel/queen
	name = "bloated plasma vessel"
	stored_plasma = 200
	max_plasma = 500

/datum/internal_organ/tyranids/plasmavessel/sentinel
	stored_plasma = 100
	max_plasma = 250

/datum/internal_organ/tyranids/plasmavessel/hunter
	name = "tiny plasma vessel"
	stored_plasma = 100
	max_plasma = 150

/datum/internal_organ/tyranids/acidgland
	name = "acid gland"
	parent_limb = "head"
	removed_type = /obj/item/organ/tyranids/acidgland

/datum/internal_organ/tyranids/hivenode
	name = "hive node"
	parent_limb = "chest"
	removed_type = /obj/item/organ/tyranids/hivenode

/datum/internal_organ/tyranids/resinspinner
	name = "resin spinner"
	parent_limb = "head"
	removed_type = /obj/item/organ/tyranids/resinspinner

/obj/item/organ/tyranids
	name = "tyranid organ"
	icon = 'icons/effects/blood.dmi'
	desc = "It smells like an accident in a chemical factory."

/obj/item/organ/tyranids/eggsac
	name = "egg sac"
	icon_state = "xgibmid1"
	organ_tag = "egg sac"
	organ_type = /datum/internal_organ/tyranids/eggsac

/obj/item/organ/tyranids/plasmavessel
	name = "plasma vessel"
	icon_state = "xgibdown1"
	organ_tag = "plasma vessel"
	organ_type = /datum/internal_organ/tyranids/plasmavessel

/obj/item/organ/tyranids/acidgland
	name = "acid gland"
	icon_state = "xgibtorso"
	organ_tag = "acid gland"
	organ_type = /datum/internal_organ/tyranids/acidgland

/obj/item/organ/tyranids/hivenode
	name = "hive node"
	icon_state = "xgibmid2"
	organ_tag = "hive node"
	organ_type = /datum/internal_organ/tyranids/hivenode

/obj/item/organ/tyranids/resinspinner
	name = "hive node"
	icon_state = "xgibmid2"
	organ_tag = "resin spinner"
	organ_type = /datum/internal_organ/tyranids/resinspinner
