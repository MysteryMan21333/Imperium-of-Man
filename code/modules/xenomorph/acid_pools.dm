
/obj/structure/tyranid/acid_pool
	name = "acid pool"
	desc = "A pool of weak viscous acid that solidifies quickly when removed from the pool. Swimming is not recommended due to the lack of a lifeguard."
	icon = 'modular_imperium/master_files/icons/tyranid/3x3building.dmi'
	icon_state = "pool"
	bound_width = 96
	bound_height = 64
	max_integrity = 400
	tyranid_structure_flags = CRITICAL_STRUCTURE|IGNORE_WEED_REMOVAL

/obj/structure/tyranid/acid_pool/Initialize(mapload, _hivenumber)
	. = ..()
	SSminimaps.add_marker(src, MINIMAP_FLAG_TYRANID, image('icons/UI_icons/map_blips.dmi', null, "acid_pool", ABOVE_FLOAT_LAYER))

/obj/structure/tyranid/acid_pool/Initialize(mapload, _hivenumber)
	. = ..()
	START_PROCESSING(SSprocessing, src)
	update_icon()

/obj/structure/tyranid/acid_pool/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "pool_emissive")

/obj/structure/tyranid/acid_pool/process()
	for(var/atom/location AS in locs)
		for(var/mob/living/carbon/tyranid/tyranid in location)
			if(tyranid.stat == DEAD)
				continue
			if(!tyranid.lying_angle)
				continue
			if(GLOB.hive_datums[hivenumber] != tyranid.hive)
				continue
			tyranid.adjust_sunder(-1)
