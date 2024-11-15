//This file exists only to keep old typepaths so the loadout system can transition them.
//we need to do that since the jatum deserialization uses text2path but byond doenst return a path
//if that path doenst exist.



/obj/item/clothing/suit/modular/pas11x
/obj/item/clothing/head/modular/guardsman/m10x/tech
/obj/item/clothing/head/modular/guardsman/m10x/corpsman
/obj/item/clothing/head/modular/guardsman/m10x/standard

/obj/item/clothing/head/helmet/guardsman/robot
/obj/item/clothing/head/helmet/guardsman/robot/light
/obj/item/clothing/head/helmet/guardsman/robot/heavy

/obj/item/clothing/suit/storage/guardsman/robot
/obj/item/clothing/suit/storage/guardsman/robot/light
/obj/item/clothing/suit/storage/guardsman/robot/heavy


/obj/item/armor_module/greyscale/badge
/obj/item/armor_module/greyscale/visor/guardsman
/obj/item/armor_module/greyscale/visor/guardsman/skirmisher
/obj/item/armor_module/greyscale/visor/guardsman/scout
/obj/item/armor_module/greyscale/visor/guardsman/eva
/obj/item/armor_module/greyscale/visor/guardsman/eva/skull
/obj/item/armor_module/greyscale/visor/guardsman/gungnir
/obj/item/armor_module/greyscale/visor/guardsman/eod
/obj/item/armor_module/greyscale/visor/guardsman/assault
/obj/item/armor_module/greyscale/visor/guardsman/helljumper
/obj/item/armor_module/greyscale/visor/guardsman/ranger
/obj/item/armor_module/greyscale/visor/guardsman/traditional
/obj/item/armor_module/greyscale/visor/guardsman/old
/obj/item/armor_module/greyscale/visor/guardsman/old/skirmisher
/obj/item/armor_module/greyscale/visor/guardsman/old/scout
/obj/item/armor_module/greyscale/visor/guardsman/old/eva
/obj/item/armor_module/greyscale/visor/guardsman/old/eva/skull
/obj/item/armor_module/greyscale/visor/guardsman/old/eod
/obj/item/armor_module/greyscale/visor/guardsman/old/assault
/obj/item/armor_module/greyscale/cape
/obj/item/armor_module/greyscale/cape/half
/obj/item/armor_module/greyscale/cape/short
/obj/item/armor_module/greyscale/cape/short/classic
/obj/item/armor_module/greyscale/cape/scarf
/obj/item/armor_module/greyscale/cape/kama
/obj/item/armor_module/greyscale/cape_highlight
/obj/item/armor_module/greyscale/cape_highlight/half
/obj/item/armor_module/greyscale/cape_highlight/scarf

/obj/item/armor_module/armor/cape/half
/obj/item/armor_module/armor/cape/scarf
/obj/item/armor_module/armor/cape/short
/obj/item/armor_module/armor/cape/short/classic

/obj/item/armor_module/armor/cape_highlight/half
/obj/item/armor_module/armor/cape_highlight/scarf

//Changing item_representation typepaths also breaks loadouts horribly.

/datum/item_representation/suit_with_storage
	///The storage of the suit
	var/datum/item_representation/storage/pockets

/datum/item_representation/modular_armor
	///List of attachments on the armor.
	var/list/datum/item_representation/armor_module/attachments = list()
	///Icon_state suffix for the saved icon_state varient.
	var/current_variant

/datum/item_representation/modular_helmet
	///The attachments installed.
	var/list/datum/item_representation/armor_module/attachments = list()
	///The color of the helmet
	var/greyscale_colors
	///Icon_state suffix for the saved icon_state varient.
	var/current_variant

/datum/item_representation/armor_module/armor
	///Icon_state suffix for the saved icon_state varient.
	var/current_variant

/datum/item_representation/armor_module/colored
	///The color of that armor module
	var/greyscale_colors
