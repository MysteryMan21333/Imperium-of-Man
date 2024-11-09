// these use typepaths to avoid issues caused by mispellings when mapping or job titles changing
/obj/effect/landmark/start/job
	var/job

/obj/effect/landmark/start/job/Initialize(mapload)
	. = ..()
	GLOB.spawns_by_job[job] += list(loc)

/obj/effect/landmark/start/job/captain
	icon_state = "CAP"
	job = /datum/job/terragov/command/captain

/obj/effect/landmark/start/job/captain/campaign
	icon_state = "CAP"
	job = /datum/job/terragov/command/captain/campaign

/obj/effect/landmark/start/job/fieldcommander
	icon_state = "FC"
	job = /datum/job/terragov/command/fieldcommander

/obj/effect/landmark/start/job/fieldcommander/campaign
	icon_state = "FC"
	job = /datum/job/terragov/command/fieldcommander/campaign

/obj/effect/landmark/start/job/staffofficer
	icon_state = "IO"
	job = /datum/job/terragov/command/staffofficer

/obj/effect/landmark/start/job/staffofficer/campaign
	icon_state = "IO"
	job = /datum/job/terragov/command/staffofficer/campaign

/obj/effect/landmark/start/job/pilotofficer
	icon_state = "PO"
	job = /datum/job/terragov/command/pilot

/obj/effect/landmark/start/job/transportofficer
	icon_state = "TO"
	job = /datum/job/terragov/command/transportofficer

/obj/effect/landmark/start/job/chiefshipengineer
	icon_state = "CSE"
	job = /datum/job/terragov/engineering/chief

/obj/effect/landmark/start/job/requisitionsofficer
	icon_state = "RO"
	job = /datum/job/terragov/requisitions/officer

/obj/effect/landmark/start/job/mechpilot
	icon_state = "MP"
	job = /datum/job/terragov/command/mech_pilot

/obj/effect/landmark/start/job/assault_crewman
	icon_state = "AC"
	job = /datum/job/terragov/command/assault_crewman

/obj/effect/landmark/start/job/transport_crewman
	icon_state = "TC"
	job = /datum/job/terragov/command/transport_crewman

/obj/effect/landmark/start/job/shiptech
	icon_state = "SE"
	job = /datum/job/terragov/engineering/tech

/obj/effect/landmark/start/job/cmo
	icon_state = "CMO"
	job = /datum/job/terragov/medical/professor

/obj/effect/landmark/start/job/medicalofficer
	icon_state = "MD"
	job = /datum/job/terragov/medical/medicalofficer

/obj/effect/landmark/start/job/researcher
	icon_state = "Research"
	job = /datum/job/terragov/medical/researcher

/obj/effect/landmark/start/job/corporateliaison
	icon_state = "CL"
	job = /datum/job/terragov/civilian/liaison

/obj/effect/landmark/start/job/synthetic
	icon_state = "Synth"
	job = /datum/job/terragov/silicon/synthetic

/obj/effect/landmark/start/job/squadguardsman
	icon_state = "PFC"
	job = /datum/job/terragov/squad/standard

/obj/effect/landmark/start/job/squadengineer
	icon_state = "Eng"
	job = /datum/job/terragov/squad/engineer

/obj/effect/landmark/start/job/squadcorpsman
	icon_state = "HM"
	job = /datum/job/terragov/squad/corpsman

/obj/effect/landmark/start/job/squadsmartgunner
	icon_state = "SGnr"
	job = /datum/job/terragov/squad/smartgunner

/obj/effect/landmark/start/job/squadspecialist
	icon_state = "Spec"
	job = /datum/job/terragov/squad/specialist

/obj/effect/landmark/start/job/squadleader
	icon_state = "SL"
	job = /datum/job/terragov/squad/leader

/obj/effect/landmark/start/job/ai
	icon_state = "AI"
	job = /datum/job/terragov/silicon/ai

/obj/effect/landmark/start/job/survivor
	icon_state = "Shaft Miner"
	job = /datum/job/survivor/rambo

/obj/effect/landmark/start/job/fallen
	job = /datum/job/fallen/guardsman

/obj/effect/landmark/start/job/fallen/tyranid
	job = /datum/job/fallen/tyranid

/obj/effect/landmark/start/job/tyranid
	icon_state = "tyranid_spawn"
	job = /datum/job/tyranid

//CHAOS
/obj/effect/landmark/start/job/chaos/squadstandard
	icon_state = "chaos_standard"
	job = /datum/job/chaos/squad/standard

/obj/effect/landmark/start/job/chaos/squadveteran
	icon_state = "chaos_veteran"
	job = /datum/job/chaos/squad/veteran

/obj/effect/landmark/start/job/chaos/squadengineer
	icon_state = "chaos_engineer"
	job = /datum/job/chaos/squad/engineer

/obj/effect/landmark/start/job/chaos/squadcorpsman
	icon_state = "chaos_medic"
	job = /datum/job/chaos/squad/medic

/obj/effect/landmark/start/job/chaos/squadleader
	icon_state = "chaos_squad_leader"
	job = /datum/job/chaos/squad/leader

/obj/effect/landmark/start/job/chaos/fieldcommander
	icon_state = "chaos_field_commander"
	job = /datum/job/chaos/command/fieldcommander

/obj/effect/landmark/start/job/chaos/commander
	icon_state = "chaos_commander"
	job = /datum/job/chaos/command/commander

/obj/effect/landmark/start/job/chaos/staff_officer
	icon_state = "chaos_staff_officer"
	job = /datum/job/chaos/command/staffofficer
