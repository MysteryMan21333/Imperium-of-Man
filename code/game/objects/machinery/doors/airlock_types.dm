
/obj/machinery/door/airlock/secure
	name = "\improper Secure Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Door_secure.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_com
	openspeed = 34

/obj/machinery/door/airlock/command
	name = "\improper Command Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/comdoor.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_com

/obj/machinery/door/airlock/command/thunderdome
	name = "\improper Thunderdome Administration"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/comdoor.dmi'
	req_access = list(ACCESS_CIVILIAN_ENGINEERING)

/obj/machinery/door/airlock/security
	name = "\improper Security Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorsec.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_sec

/obj/machinery/door/airlock/engineering
	name = "\improper Engineering Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/engidoor.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_eng

/obj/machinery/door/airlock/engineering/evac
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/pod_doors.dmi'
	icon_state = "door_locked"

/obj/machinery/door/airlock/medical
	name = "\improper Medical Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/medidoor.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_med

/obj/machinery/door/airlock/maintenance
	name = "\improper Maintenance Hatch"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/maintdoor.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_mai

/obj/machinery/door/airlock/external
	name = "\improper External Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorext.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_ext

/obj/machinery/door/airlock/external/brig
	req_access = list(ACCESS_GUARDSMAN_BRIG)

/obj/machinery/door/airlock/glass
	name = "\improper Glass Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/personaldoor.dmi'
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/centcom
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/securedoor.dmi'
	opacity = TRUE

/obj/machinery/door/airlock/vault
	name = "\improper Vault"
	icon = 'modular_imperium/master_files/icons/obj/doors/vault.dmi'
	opacity = TRUE
	assembly_type = /obj/structure/door_assembly/door_assembly_highsecurity //Until somebody makes better sprites.

/obj/machinery/door/airlock/freezer
	name = "\improper Freezer Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/personaldoor.dmi'
	opacity = TRUE
	assembly_type = /obj/structure/door_assembly/door_assembly_fre

/obj/machinery/door/airlock/hatch
	name = "\improper Airtight Hatch"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/securedoor.dmi'
	opacity = TRUE
	assembly_type = /obj/structure/door_assembly/door_assembly_hatch

/obj/machinery/door/airlock/hatch/engineering
	req_access = list(ACCESS_GUARDSMAN_ENGINEERING)

/obj/machinery/door/airlock/maintenance_hatch
	name = "\improper Maintenance Hatch"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/maintdoor.dmi'
	opacity = TRUE
	assembly_type = /obj/structure/door_assembly/door_assembly_mhatch

/obj/machinery/door/airlock/glass_command
	name = "\improper Command Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/comdoor.dmi'
	opacity = FALSE
	assembly_type = /obj/structure/door_assembly/door_assembly_com
	glass = TRUE

/obj/machinery/door/airlock/glass_engineering
	name = "\improper Engineering Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/engidoor.dmi'
	opacity = FALSE
	assembly_type = /obj/structure/door_assembly/door_assembly_eng
	glass = TRUE

/obj/machinery/door/airlock/glass_security
	name = "\improper Security Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorsec.dmi'
	opacity = FALSE
	assembly_type = /obj/structure/door_assembly/door_assembly_sec
	glass = TRUE

/obj/machinery/door/airlock/glass_security/locked
	icon_state = "door_locked"
	locked = TRUE

/obj/machinery/door/airlock/glass_medical
	name = "\improper Medical Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doormedglass.dmi'
	opacity = FALSE
	assembly_type = /obj/structure/door_assembly/door_assembly_med
	glass = TRUE

/obj/machinery/door/airlock/mining
	name = "\improper Mining Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doormining.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_min

/obj/machinery/door/airlock/guardsman
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/door_marines.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_min

/obj/machinery/door/airlock/atmos
	name = "\improper Atmospherics Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Dooratmo.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_atmo

/obj/machinery/door/airlock/research
	name = "\improper Research Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorresearch.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_research

/obj/machinery/door/airlock/glass_research
	name = "\improper Research Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorresearchglass.dmi'
	opacity = FALSE
	assembly_type = /obj/structure/door_assembly/door_assembly_research
	glass = TRUE

/obj/machinery/door/airlock/glass_mining
	name = "\improper Mining Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorminingglass.dmi'
	opacity = FALSE
	assembly_type = /obj/structure/door_assembly/door_assembly_min
	glass = TRUE

/obj/machinery/door/airlock/glass_atmos
	name = "\improper Atmospherics Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Dooratmoglass.dmi'
	opacity = FALSE
	assembly_type = /obj/structure/door_assembly/door_assembly_atmo
	glass = TRUE

/obj/machinery/door/airlock/gold
	name = "\improper Gold Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorgold.dmi'
	mineral = "gold"

/obj/machinery/door/airlock/silver
	name = "\improper Silver Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorsilver.dmi'
	mineral = "silver"

/obj/machinery/door/airlock/diamond
	name = "\improper Diamond Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doordiamond.dmi'
	mineral = "diamond"

/obj/machinery/door/airlock/uranium
	name = "\improper Uranium Airlock"
	desc = "And they said I was crazy."
	icon = 'modular_imperium/master_files/icons/obj/doors/Dooruranium.dmi'
	mineral = "uranium"


/obj/machinery/door/airlock/phoron
	name = "\improper Phoron Airlock"
	desc = "No way this can end badly."
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorphoron.dmi'
	mineral = "phoron"



/obj/machinery/door/airlock/sandstone
	name = "\improper Sandstone Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorsand.dmi'
	mineral = "sandstone"

/obj/machinery/door/airlock/science
	name = "\improper Research Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorsci.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_science

/obj/machinery/door/airlock/glass_science
	name = "\improper Research Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorsciglass.dmi'
	opacity = FALSE
	assembly_type = /obj/structure/door_assembly/door_assembly_science
	glass = TRUE

/obj/machinery/door/airlock/highsecurity
	name = "\improper High Tech Security Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/hightechsecurity.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_highsecurity





//GUARDSMAN SHIP AIRLOCKS

/obj/machinery/door/airlock/mainship
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/comdoor.dmi' //Tiles with is here FOR SAFETY PURPOSES
	openspeed = 4 //shorter open animation.

/obj/machinery/door/airlock/mainship/security
	name = "\improper Security Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/secdoor.dmi'
	req_access = list(ACCESS_GUARDSMAN_BRIG)

/obj/machinery/door/airlock/mainship/security/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/security/locked
	icon_state = "door_locked"
	locked = TRUE

/obj/machinery/door/airlock/mainship/security/locked/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/security/checkpoint
	name = "\improper Security Checkpoint"

/obj/machinery/door/airlock/mainship/security/CMA
	name = "\improper Chief Master at Arms's Bunks"

/obj/machinery/door/airlock/mainship/security/glass
	name = "\improper Security Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/secdoor_glass.dmi'
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/mainship/security/glass/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/security/glass/office
	name = "\improper Security Office"

/obj/machinery/door/airlock/mainship/security/glass/cells
	name = "\improper Security Cells"

/obj/machinery/door/airlock/mainship/security/glass/CMA
	name = "\improper Chief Master at Arms's Office"

/obj/machinery/door/airlock/mainship/command
	name = "\improper Command Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/comdoor.dmi'
	req_access = list(ACCESS_GUARDSMAN_BRIDGE)

/obj/machinery/door/airlock/mainship/command/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/command/locked
	icon_state = "door_locked"
	locked = TRUE

/obj/machinery/door/airlock/mainship/command/locked/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/command/open
	icon_state = "door_open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/airlock/mainship/command/open/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/command/canterbury //For wall-smoothing
	req_access = list(ACCESS_GUARDSMAN_DROPSHIP)

/obj/machinery/door/airlock/mainship/command/cic
	name = "\improper Combat Information Center"

/obj/machinery/door/airlock/mainship/command/brief
	name = "\improper Briefing Room"

/obj/machinery/door/airlock/mainship/command/CPToffice
	name = "\improper Captain's Office"

/obj/machinery/door/airlock/mainship/command/CPTstudy
	name = "\improper Captain's Study"
	req_access = list(ACCESS_GUARDSMAN_CAPTAIN)

/obj/machinery/door/airlock/mainship/command/CPTmess
	name = "\improper Captain's Mess"

/obj/machinery/door/airlock/mainship/command/FCDRoffice
	name = "\improper Field Commander's Office"

/obj/machinery/door/airlock/mainship/command/FCDRquarters
	name = "\improper FCDR's Quarters"

/obj/machinery/door/airlock/mainship/command/officer
	name = "\improper Officer's Quarters"

/obj/machinery/door/airlock/mainship/secure
	name = "\improper Secure Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/securedoor.dmi'
	req_access = list(ACCESS_GUARDSMAN_BRIDGE)

/obj/machinery/door/airlock/mainship/secure/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/secure/locked
	icon_state = "door_locked"
	locked = TRUE

/obj/machinery/door/airlock/mainship/secure/locked/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/secure/open
	icon_state = "door_open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/airlock/mainship/secure/open/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/secure/tcomms
	name = "\improper Telecommunications"

/obj/machinery/door/airlock/mainship/secure/evac
	name = "\improper Evacuation Airlock"

/obj/machinery/door/airlock/mainship/secure/evac/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_EVACUATION_STARTED, PROC_REF(force_open))

///Force open that door
/obj/machinery/door/airlock/mainship/secure/proc/force_open()
	SIGNAL_HANDLER
	unlock(TRUE)
	INVOKE_ASYNC(src, PROC_REF(open), TRUE)
	lock(TRUE)

/obj/machinery/door/airlock/mainship/ai
	name = "\improper AI Core"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/personaldoor.dmi'
	req_access = list(ACCESS_GUARDSMAN_BRIDGE)

/obj/machinery/door/airlock/mainship/ai/glass
	name = "\improper AI Core"
	icon = 'modular_imperium/master_files/icons/obj/doors/Doorglass.dmi'
	opacity = FALSE
	glass = TRUE



/obj/machinery/door/airlock/mainship/evacuation
	name = "\improper Evacuation Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/securedoor.dmi'


/obj/machinery/door/airlock/mainship/maint
	name = "\improper Maintenance Hatch"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/maintdoor.dmi'
	req_one_access = list(ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_ENGINEERING)

/obj/machinery/door/airlock/mainship/maint/free_access

/obj/machinery/door/airlock/mainship/maint/core
	name = "\improper Core Hatch"

/obj/machinery/door/airlock/mainship/maint/hangar
	name = "\improper Hangar Control Room"
	req_one_access = list(ACCESS_GUARDSMAN_DROPSHIP)

/obj/machinery/door/airlock/mainship/engineering
	name = "\improper Engineering Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/engidoor.dmi'
	opacity = FALSE
	glass = TRUE
	req_one_access = list(ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_ENGINEERING)

/obj/machinery/door/airlock/mainship/engineering/glass
	name = "\improper Engineering Glass Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/engidoor_glass.dmi'

/obj/machinery/door/airlock/mainship/engineering/glass/free_access
	req_one_access = null

/obj/machinery/door/airlock/mainship/engineering/free_access
	req_one_access = null

/obj/machinery/door/airlock/mainship/engineering/storage
	name = "\improper Engineering Storage"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/maintdoor.dmi'

/obj/machinery/door/airlock/mainship/engineering/disposals
	name = "\improper Disposals"

/obj/machinery/door/airlock/mainship/engineering/workshop
	name = "\improper Engineering Workshop"

/obj/machinery/door/airlock/mainship/engineering/engine
	name = "\improper Engineering Engine Monitoring"

/obj/machinery/door/airlock/mainship/engineering/atmos
	name = "\improper Atmospherics Wing"

/obj/machinery/door/airlock/mainship/engineering/CSEoffice
	name = "\improper Chief Ship Engineer's Office"
	req_access = list(ACCESS_GUARDSMAN_CE)

/obj/machinery/door/airlock/mainship/engineering/server_room
	name = "\improper Server Room"
	req_one_access = null

/obj/machinery/door/airlock/mainship/medical
	name = "\improper Medical Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/medidoor.dmi'
	req_one_access = list(ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_BRIDGE)


/obj/machinery/door/airlock/mainship/medical/free_access
	req_one_access = list()

/obj/machinery/door/airlock/mainship/medical/morgue
	name = "\improper Morgue"
	req_access = list(ACCESS_GUARDSMAN_CHEMISTRY)

/obj/machinery/door/airlock/mainship/medical/or
	name = "\improper Operating Theatre"

/obj/machinery/door/airlock/mainship/medical/or/or1
	name = "\improper Operating Theatre 1"
/obj/machinery/door/airlock/mainship/medical/or/or2
	name = "\improper Operating Theatre 2"

/obj/machinery/door/airlock/mainship/medical/or/or3
	name = "\improper Operating Theatre 3"

/obj/machinery/door/airlock/mainship/medical/or/or4
	name = "\improper Operating Theatre 4"

/obj/machinery/door/airlock/mainship/medical/or/free_access
	req_one_access = null

/obj/machinery/door/airlock/mainship/medical/glass
	name = "\improper Medical Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/medidoor_glass.dmi'
	opacity = FALSE
	glass = TRUE
	req_one_access = list(ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_MEDBAY, ACCESS_GUARDSMAN_BRIDGE)

/obj/machinery/door/airlock/mainship/medical/glass/free_access
	req_one_access = null

/obj/machinery/door/airlock/mainship/medical/glass/CMO
	name = "\improper CMO's Office"
	req_access = list(ACCESS_GUARDSMAN_CMO)

/obj/machinery/door/airlock/mainship/medical/glass/chemistry
	name = "\improper Chemistry Laboratory"

/obj/machinery/door/airlock/mainship/medical/glass/research
	req_access = list(ACCESS_GUARDSMAN_RESEARCH)

/obj/machinery/door/airlock/mainship/research
	name = "\improper Research Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/medidoor.dmi'
	req_access = list(ACCESS_GUARDSMAN_RESEARCH)

/obj/machinery/door/airlock/mainship/research/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/research/open
	icon_state = "door_open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/airlock/mainship/research/open/free_access
	req_one_access = null

/obj/machinery/door/airlock/mainship/research/locked
	icon_state = "door_locked"
	locked = TRUE

/obj/machinery/door/airlock/mainship/research/locked/free_access
	req_one_access = null

/obj/machinery/door/airlock/mainship/research/chemistry
	name = "\improper Chemistry Laboratory"
	req_access = list(ACCESS_GUARDSMAN_CHEMISTRY)

/obj/machinery/door/airlock/mainship/research/or
	name = "\improper Experimental Operating Theatre"

/obj/machinery/door/airlock/mainship/research/pen
	name = "\improper Research Pens"

/obj/machinery/door/airlock/mainship/research/glass
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/medidoor_glass.dmi'
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/mainship/research/glass/wing
	name = "\improper Medical Research Wing"
	id = "researchdoorext"

/obj/machinery/door/airlock/mainship/research/glass/cell
	name = "\improper Containment Cell"
	id = "Containment Cell"
	icon_state = "door_locked"
	locked = TRUE

/obj/machinery/door/airlock/mainship/research/glass/cell/cell1
	name = "\improper Containment Cell 1"
	id = "Containment Cell 1"

/obj/machinery/door/airlock/mainship/research/glass/cell/cell2
	name = "\improper Containment Cell 2"
	id = "Containment Cell 2"

/obj/machinery/door/airlock/mainship/research/glass/free_access
	req_access = null

/obj/machinery/door/airlock/mainship/generic
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/personaldoor.dmi'

/obj/machinery/door/airlock/mainship/generic/corporate
	name = "Corporate Liaison's Office"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/personaldoor.dmi'
	req_access = list(ACCESS_NT_CORPORATE)

/obj/machinery/door/airlock/mainship/generic/corporate/quarters
	name = "Corporate Liaison's Quarters"

/obj/machinery/door/airlock/mainship/generic/bathroom
	name = "\improper Bathroom"

/obj/machinery/door/airlock/mainship/generic/bathroom/toilet
	name = "\improper Toilet"

/obj/machinery/door/airlock/mainship/generic/pilot
	name = "\improper Pilot's Office"
	req_access = list(ACCESS_GUARDSMAN_PILOT)

/obj/machinery/door/airlock/mainship/generic/pilot/bunk
	name = "\improper Pilot's Bunks"

/obj/machinery/door/airlock/mainship/generic/pilot/quarters
	name = "\improper Pilot's Quarters"

/obj/machinery/door/airlock/mainship/generic/mech_pilot
	name = "\improper Mech Pilot's Office"
	req_access = list(ACCESS_GUARDSMAN_MECH)

/obj/machinery/door/airlock/mainship/generic/mech_pilot/bunk
	name = "\improper Mech Pilot's Bunks"

/obj/machinery/door/airlock/mainship/generic/ert
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/personaldoor.dmi'
	interaction_flags = INTERACT_MACHINE_NOSILICON //go away naughty AI

/obj/machinery/door/airlock/mainship/generic/glass
	name = "\improper Glass Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/personaldoor_glass.dmi'

/obj/machinery/door/airlock/mainship/guardsman
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor.dmi'
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/mainship/guardsman/handle_weldingtool_overlay(removing = FALSE)
	if(!removing)
		if(dir & NORTH|SOUTH)
			add_overlay(GLOB.welding_sparks_prepdoor)
		else
			add_overlay(GLOB.welding_sparks)
	else
		if(dir & NORTH|SOUTH)
			cut_overlay(GLOB.welding_sparks_prepdoor)
		else
			cut_overlay(GLOB.welding_sparks)

/obj/machinery/door/airlock/mainship/guardsman/canterbury //For wallsmoothing

/obj/machinery/door/airlock/mainship/guardsman/general/sl
	name = "\improper Squad Leader Preparations"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor.dmi'
	req_access = list(ACCESS_GUARDSMAN_LEADER)
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/mainship/guardsman/general/smart
	name = "\improper Smartgunner Preparations"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor.dmi'
	req_access = list(ACCESS_GUARDSMAN_SMARTPREP)
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/mainship/guardsman/general/corps
	name = "\improper Corpsman Preparations"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor.dmi'
	req_access = list(ACCESS_GUARDSMAN_MEDPREP)
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/mainship/guardsman/general/engi
	name = "\improper Engineer Preparations"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor.dmi'
	req_access = list(ACCESS_GUARDSMAN_ENGPREP)
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/mainship/guardsman/requisitions
	name = "\improper Requisitions Bay"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor.dmi'
	req_one_access = list(ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_CARGO)
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/mainship/guardsman/requisitions/lift
	name = "\improper ASRS Lift"
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/alpha
	name = "\improper Alpha Squad Preparations"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor_alpha.dmi'
	req_access = list(ACCESS_GUARDSMAN_PREP)
	req_one_access = list(ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_ALPHA)
	opacity = FALSE
	glass = TRUE
	dir = SOUTH

/obj/machinery/door/airlock/mainship/guardsman/alpha/sl
	name = "\improper Alpha Squad Leader Preparations"
	req_access = list(ACCESS_GUARDSMAN_LEADER, ACCESS_GUARDSMAN_ALPHA)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/alpha/engineer
	name = "\improper Alpha Squad Engineer Preparations"
	req_access = list(ACCESS_GUARDSMAN_ENGPREP, ACCESS_GUARDSMAN_ALPHA)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/alpha/medic
	name = "\improper Alpha Squad Medic Preparations"
	req_access = list(ACCESS_GUARDSMAN_MEDPREP, ACCESS_GUARDSMAN_ALPHA)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/alpha/smart
	name = "\improper Alpha Squad Smartgunner Preparations"
	req_access = list(ACCESS_GUARDSMAN_SMARTPREP, ACCESS_GUARDSMAN_ALPHA)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/bravo
	name = "\improper Bravo Squad Preparations"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor_bravo.dmi'
	req_access = list(ACCESS_GUARDSMAN_PREP)
	req_one_access = list(ACCESS_GUARDSMAN_LOGISTICS,ACCESS_GUARDSMAN_BRAVO)
	opacity = FALSE
	glass = TRUE
	dir = SOUTH

/obj/machinery/door/airlock/mainship/guardsman/bravo/sl
	name = "\improper Bravo Squad Leader Preparations"
	req_access = list(ACCESS_GUARDSMAN_LEADER, ACCESS_GUARDSMAN_BRAVO)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/bravo/engineer
	name = "\improper Bravo Squad Engineer Preparations"
	req_access = list(ACCESS_GUARDSMAN_ENGPREP, ACCESS_GUARDSMAN_BRAVO)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/bravo/medic
	name = "\improper Bravo Squad Medic Preparations"
	req_access = list(ACCESS_GUARDSMAN_MEDPREP, ACCESS_GUARDSMAN_BRAVO)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/bravo/smart
	name = "\improper Bravo Squad Smartgunner Preparations"
	req_access = list(ACCESS_GUARDSMAN_SMARTPREP, ACCESS_GUARDSMAN_BRAVO)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/charlie
	name = "\improper Charlie Squad Preparations"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor_charlie.dmi'
	req_access = list(ACCESS_GUARDSMAN_PREP)
	req_one_access = list(ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_CHARLIE)
	opacity = FALSE
	glass = TRUE
	dir = SOUTH

/obj/machinery/door/airlock/mainship/guardsman/charlie/sl
	name = "\improper Charlie Squad Leader Preparations"
	req_access = list(ACCESS_GUARDSMAN_LEADER, ACCESS_GUARDSMAN_CHARLIE)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/charlie/engineer
	name = "\improper Charlie Squad Engineer Preparations"
	req_access = list(ACCESS_GUARDSMAN_ENGPREP, ACCESS_GUARDSMAN_CHARLIE)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/charlie/medic
	name = "\improper Charlie Squad Medic Preparations"
	req_access = list(ACCESS_GUARDSMAN_MEDPREP, ACCESS_GUARDSMAN_CHARLIE)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/charlie/smart
	name = "\improper Charlie Squad Smartgunner Preparations"
	req_access = list(ACCESS_GUARDSMAN_SMARTPREP, ACCESS_GUARDSMAN_CHARLIE)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/delta
	name = "\improper Delta Squad Preparations"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/prepdoor_delta.dmi'
	req_access = list(ACCESS_GUARDSMAN_PREP)
	req_one_access = list(ACCESS_GUARDSMAN_LOGISTICS, ACCESS_GUARDSMAN_DELTA)
	opacity = FALSE
	glass = TRUE
	dir = SOUTH

/obj/machinery/door/airlock/mainship/guardsman/delta/sl
	name = "\improper Delta Squad Leader Preparations"
	req_access = list(ACCESS_GUARDSMAN_LEADER, ACCESS_GUARDSMAN_DELTA)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/delta/engineer
	name = "\improper Delta Squad Engineer Preparations"
	req_access = list(ACCESS_GUARDSMAN_ENGPREP, ACCESS_GUARDSMAN_DELTA)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/delta/medic
	name = "\improper Delta Squad Medic Preparations"
	req_access = list(ACCESS_GUARDSMAN_MEDPREP, ACCESS_GUARDSMAN_DELTA)
	req_one_access = null

/obj/machinery/door/airlock/mainship/guardsman/delta/smart
	name = "\improper Delta Squad Smartgunner Preparations"
	req_access = list(ACCESS_GUARDSMAN_SMARTPREP, ACCESS_GUARDSMAN_DELTA)
	req_one_access = null



//DROPSHIP SIDE AIRLOCKS

/obj/machinery/door/airlock/dropship_hatch
	name = "\improper Dropship Hatch"
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/dropship1_side.dmi' //Tiles with is here FOR SAFETY PURPOSES
	id = "sh_dropship1"
	openspeed = 4 //shorter open animation.
	resistance_flags = RESIST_ALL
	no_panel = TRUE
	not_weldable = TRUE

/obj/machinery/door/airlock/dropship_hatch/proc/lockdown()
	unlock()
	close()
	lock()

/obj/machinery/door/airlock/dropship_hatch/proc/release()
	unlock()

/obj/machinery/door/airlock/dropship_hatch/ex_act(severity)
	return

/obj/machinery/door/airlock/dropship_hatch/close(forced=0)
	if(forced)
		for(var/mob/living/L in loc)
			step(L, pick(EAST,WEST)) // bump them off the tile
		safe = 0 // in case anyone tries to run into the closing door~
		..()
		safe = 1 // without having to rewrite closing proc~spookydonut
	else
		..()


/obj/machinery/door/airlock/dropship_hatch/left
	dir = EAST

/obj/machinery/door/airlock/dropship_hatch/right
	dir = WEST

/obj/machinery/door/airlock/dropship_hatch/left/two
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/dropship2_side.dmi' //Tiles with is here FOR SAFETY PURPOSES
	id = "sh_dropship2"

/obj/machinery/door/airlock/dropship_hatch/right/two
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/dropship2_side.dmi' //Tiles with is here FOR SAFETY PURPOSES
	id = "sh_dropship2"

/obj/machinery/door/airlock/hatch/cockpit
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/dropship1_pilot.dmi'
	name = "\improper Cockpit"
	req_access = list(ACCESS_GUARDSMAN_DROPSHIP)
	resistance_flags = RESIST_ALL
	no_panel = TRUE
	not_weldable = TRUE

/obj/machinery/door/airlock/hatch/cockpit/canAIControl(mob/user)
	return TRUE

/obj/machinery/door/airlock/hatch/cockpit/two
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/dropship2_pilot.dmi'

//PRISON AIRLOCKS
/obj/machinery/door/airlock/prison
	name = "\improper Cell Door"
	icon = 'modular_imperium/master_files/icons/obj/doors/prison/celldoor.dmi'

/obj/machinery/door/airlock/prison/open
	icon_state = "door_open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/airlock/prison/horizontal
	dir = SOUTH

/obj/machinery/door/airlock/prison/horizontal/open
	icon_state = "door_open"
	density = FALSE
	opacity = FALSE


//Colony Mapped Doors
/obj/machinery/door/airlock/colony

/obj/machinery/door/airlock/colony/engineering
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/engidoor.dmi'
	opacity = FALSE
	glass = TRUE
	req_access = list(ACCESS_CIVILIAN_ENGINEERING)

/obj/machinery/door/airlock/colony/engineering/smes
	name = "\improper Engineering Dome SMES"

/obj/machinery/door/airlock/colony/engineering/nexusstorage
	name = "\improper Nexus Cargo Storage"

/obj/machinery/door/airlock/colony/engineering/nexusstorage/open
	icon_state = "door_open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/airlock/colony/medical
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/medidoor_glass.dmi'
	opacity = FALSE
	glass = TRUE
	req_access = list(ACCESS_CIVILIAN_MEDICAL)

/obj/machinery/door/airlock/colony/medical/domestorage
	name = "\improper Medical Dome Storage"

/obj/machinery/door/airlock/colony/medical/domesurgery
	name = "\improper Medical Dome Surgery"

/obj/machinery/door/airlock/colony/medical/domelockers
	name = "\improper Medical Dome Lockers"

/obj/machinery/door/airlock/colony/medical/hydroponics
	name = "\improper Hydroponics Dome"
	req_access = list(ACCESS_CIVILIAN_PUBLIC)


/obj/machinery/door/airlock/colony/research
	icon = 'modular_imperium/master_files/icons/obj/doors/mainship/medidoor.dmi'
	req_access = list(ACCESS_CIVILIAN_RESEARCH)

/obj/machinery/door/airlock/colony/research/dome
	name = "\improper Research Dome"
	icon_state = "door_locked"
	locked = TRUE

// urban doors

/obj/machinery/door/airlock/urban
	openspeed = 4
	icon_state = "door_closed"
	req_access = null

/obj/machinery/door/airlock/urban/generic
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/hybrisa/hybrisa_generic_glass.dmi'
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/urban/generic_solid
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/hybrisa/hybrisa_generic.dmi'

// Medical

/obj/machinery/door/airlock/urban/medical
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/hybrisa/hybrisa_medidoor_glass.dmi'
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/urban/medical_solid
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/hybrisa/hybrisa_medidoor.dmi'

// Personal
/obj/machinery/door/airlock/urban/personal
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/hybrisa/hybrisa_personaldoor_glass.dmi'
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/urban/personal_solid
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/hybrisa/hybrisa_personaldoor.dmi'

// Personal White
/obj/machinery/door/airlock/urban/personal_white
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/hybrisa/hybrisa_personaldoor_glass_white.dmi'
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/urban/personal_solid_white
	name = "\improper Airlock"
	icon = 'modular_imperium/master_files/icons/obj/doors/hybrisa/hybrisa_personaldoor_white.dmi'

