//misc campaign structures/landmark spawners. Make sure mission types are set correctly, with child types made as required to avoid conflicts
/obj/effect/landmark/campaign_structure/barricade
	name = "fire_support_raid_barricade"
	icon = 'modular_imperium/master_files/icons/obj/structures/barricades/metal.dmi'
	icon_state = "metal_0"
	mission_types = list(/datum/campaign_mission/destroy_mission/fire_support_raid)
	spawn_object = /obj/structure/barricade/metal

/obj/effect/landmark/campaign_structure/barricade/sandbags
	name = "fire_support_raid_sandbags"
	icon = 'modular_imperium/master_files/icons/obj/structures/barricades/sandbags.dmi'
	icon_state = "sandbag_0"
	mission_types = list(/datum/campaign_mission/destroy_mission/fire_support_raid)
	spawn_object = /obj/structure/barricade/sandbags

/obj/effect/landmark/campaign_structure/barricade/sandbags/chaos
	mission_types = list(/datum/campaign_mission/destroy_mission/fire_support_raid/chaos)

/obj/effect/landmark/campaign_structure/barricade/sandbags/asat
	name = "ASAT_capture_sandbags"
	mission_types = list(/datum/campaign_mission/capture_mission/asat)

/obj/effect/landmark/campaign_structure/barricade/concrete
	name = "fire_support_raid_concrete"
	icon = 'modular_imperium/master_files/icons/obj/structures/barricades/concrete.dmi'
	icon_state = "concrete_0"
	mission_types = list(/datum/campaign_mission/destroy_mission/fire_support_raid)
	spawn_object = /obj/structure/barricade/concrete
