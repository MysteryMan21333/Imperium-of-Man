#define SSJOB_OVERRIDE_JOBS_START (1<<0)

#define JOB_DISPLAY_ORDER_DEFAULT 0

#define JOB_DISPLAY_ORDER_TYRANID_QUEEN 1
#define JOB_DISPLAY_ORDER_TYRANID 2
#define JOB_DISPLAY_ORDER_CAPTAIN 3
#define JOB_DISPLAY_ORDER_EXECUTIVE_OFFICER 4
#define JOB_DISPLAY_ORDER_STAFF_OFFICER 5
#define JOB_DISPLAY_ORDER_PILOT_OFFICER 6
#define JOB_DISPLAY_ORDER_MECH_PILOT 7
#define JOB_DISPLAY_ORDER_CORPORATE_LIAISON 8
#define JOB_DISPLAY_ORDER_SYNTHETIC 9
#define JOB_DISPLAY_ORDER_AI 10
#define JOB_DISPLAY_ORDER_TRANSPORT_OFFICER 11
#define JOB_DISPLAY_ORDER_CHIEF_ENGINEER 13
#define JOB_DISPLAY_ORDER_SHIP_TECH 14
#define JOB_DISPLAY_ORDER_REQUISITIONS_OFFICER 15
#define JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER 16
#define JOB_DISPLAY_ORDER_DOCTOR 17
#define JOB_DISPLAY_ORDER_MEDICAL_RESEARCHER 18
#define JOB_DISPLAY_ORDER_SQUAD_LEADER 19
#define JOB_DISPLAY_ORDER_SQUAD_SMARTGUNNER 20
#define JOB_DISPLAY_ORDER_SQUAD_CORPSMAN 21
#define JOB_DISPLAY_ORDER_SUQAD_ENGINEER 22
#define JOB_DISPLAY_ORDER_SQUAD_GUARDSMAN 23
#define JOB_DISPLAY_ORDER_SURVIVOR 24

#define JOB_FLAG_SPECIALNAME (1<<0)
#define JOB_FLAG_LATEJOINABLE (1<<1) //Can this job be selected for prefs to join as?
#define JOB_FLAG_ROUNDSTARTJOINABLE (1<<2) //Joinable at roundstart
#define JOB_FLAG_NOHEADSET (1<<3) //Doesn't start with a headset on spawn.
#define JOB_FLAG_ALLOWS_PREFS_GEAR (1<<4) //Allows preference loadouts.
#define JOB_FLAG_PROVIDES_BANK_ACCOUNT (1<<5) //$$$
#define JOB_FLAG_OVERRIDELATEJOINSPAWN (1<<6) //AIs and tyranids, for example.
#define JOB_FLAG_ADDTOMANIFEST (1<<7) //Add info to datacore.
#define JOB_FLAG_ISCOMMAND (1<<8)
#define JOB_FLAG_BOLD_NAME_ON_SELECTION (1<<9)
#define JOB_FLAG_PROVIDES_SQUAD_HUD (1<<10)
#define JOB_FLAG_HIDE_CURRENT_POSITIONS (1<<11) //You can't see how many people have joined as on the latejoin menu.
#define JOB_FLAG_CAN_SEE_ORDERS (1<<12) //Able to see rally and CIC orders
#define JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP (1<<13) //Will appear on all minimaps, including squad minimaps
#define JOB_FLAG_SHOW_OPEN_POSITIONS (1<<14) //You can only see how many positions are opened, and not how many positions are fullfilled
/// Job has a TTS volume bonus
#define JOB_FLAG_LOUDER_TTS (1<<15)

#define CAPTAIN "Captain"
#define EXECUTIVE_OFFICER "Executive Officer" //Currently disabled.
#define FIELD_COMMANDER "Field Commander"
#define STAFF_OFFICER "Staff Officer"
#define TRANSPORT_OFFICER "Transport Officer"
#define PILOT_OFFICER "Pilot Officer"
#define MECH_PILOT "Mech Pilot"
#define ASSAULT_CREWMAN "Assault Crewman"
#define TRANSPORT_CREWMAN "Transport Crewman"
#define REQUISITIONS_OFFICER "Requisitions Officer"
#define CHIEF_SHIP_ENGINEER "Chief Ship Engineer"
#define CHIEF_MEDICAL_OFFICER "Chief Medical Officer"
#define CORPORATE_LIAISON "Corporate Liaison"
#define SYNTHETIC "Synthetic"
#define SHIP_TECH "Ship Technician"
#define MEDICAL_DOCTOR "Medical Doctor"
#define MEDICAL_RESEARCHER "Medical Researcher"
#define SQUAD_LEADER "Squad Leader"
#define SQUAD_SPECIALIST "Squad Specialist"
#define SQUAD_SMARTGUNNER "Squad Smartgunner"
#define SQUAD_CORPSMAN "Squad Corpsman"
#define SQUAD_ENGINEER "Squad Engineer"
#define SQUAD_GUARDSMAN "Squad Guardsman"
#define SQUAD_ROBOT "Squad Robot"
#define SQUAD_VATGROWN "Squad VatGrown"
#define SILICON_AI "AI"

//CHAOS
#define CHAOS_COMMANDER "CHAOS Commander"
#define CHAOS_FIELD_COMMANDER "CHAOS Field Commander"
#define CHAOS_STAFF_OFFICER "CHAOS Staff Officer"
#define CHAOS_PILOT_OFFICER "CHAOS Pilot Officer"
#define CHAOS_MECH_PILOT "CHAOS Mech Pilot"
#define CHAOS_REQUISITIONS_OFFICER "CHAOS Requisitions Officer"
#define CHAOS_CHIEF_ENGINEER "CHAOS Chief Engineer"
#define CHAOS_CHIEF_MEDICAL_OFFICER "CHAOS Chief Medical Officer"
#define CHAOS_TECH "CHAOS Technician"
#define CHAOS_MEDICAL_DOCTOR "CHAOS Medical Doctor"
#define CHAOS_CHEF "CHAOS chef"

#define CHAOS_SQUAD_LEADER "CHAOS Squad Leader"
#define CHAOS_SQUAD_CORPSMAN "CHAOS Squad Medic"
#define CHAOS_SQUAD_ENGINEER "CHAOS Squad Engineer"
#define CHAOS_SQUAD_VETERAN "CHAOS Squad Veteran"
#define CHAOS_SQUAD_GUARDSMAN "CHAOS Squad Standard"

#define JOB_CAT_COMMAND "Command"
#define JOB_CAT_SILICON "Silicon"
#define JOB_CAT_REQUISITIONS "Requisitions"
#define JOB_CAT_MEDICAL "Medical"
#define JOB_CAT_ENGINEERING "Engineering"
#define JOB_CAT_CIVILIAN "Civilian"
#define JOB_CAT_GUARDSMAN "Guardsman"
#define JOB_CAT_TYRANID "Tyranid"
#define JOB_CAT_UNASSIGNED "Unassigned"

#define JOB_COMM_TITLE_SQUAD_LEADER "SL"

#define ROLE_TYRANID "Tyranid"
#define ROLE_TYRANID_QUEEN "Tyranid Queen"
#define ROLE_ERT "Emergency Response Team"
#define ROLE_VALHALLA "Valhalla"

#define ROLE_FALLEN(role) ("Fallen " + ##role)

GLOBAL_LIST_EMPTY(jobs_command)
GLOBAL_LIST_INIT(jobs_officers, list(CAPTAIN, FIELD_COMMANDER, STAFF_OFFICER, PILOT_OFFICER, TRANSPORT_OFFICER, MECH_PILOT, ASSAULT_CREWMAN, TRANSPORT_CREWMAN, CORPORATE_LIAISON, SYNTHETIC, SILICON_AI))
GLOBAL_LIST_INIT(jobs_support, list(PILOT_OFFICER, TRANSPORT_OFFICER, MECH_PILOT, REQUISITIONS_OFFICER, SYNTHETIC, SILICON_AI))
GLOBAL_LIST_INIT(jobs_engineering, list(CHIEF_SHIP_ENGINEER, SHIP_TECH))
GLOBAL_LIST_INIT(jobs_requisitions, list(REQUISITIONS_OFFICER))
GLOBAL_LIST_INIT(jobs_medical, list(CHIEF_MEDICAL_OFFICER, MEDICAL_DOCTOR, MEDICAL_RESEARCHER))
GLOBAL_LIST_INIT(jobs_guardsmans, list(SQUAD_LEADER, SQUAD_SMARTGUNNER, SQUAD_CORPSMAN, SQUAD_ENGINEER, SQUAD_GUARDSMAN))
GLOBAL_LIST_INIT(jobs_som, list(CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER, CHAOS_STAFF_OFFICER, CHAOS_COMMANDER))
GLOBAL_LIST_INIT(jobs_regular_all, list(CAPTAIN, FIELD_COMMANDER, STAFF_OFFICER, PILOT_OFFICER, TRANSPORT_OFFICER, MECH_PILOT, REQUISITIONS_OFFICER, CHIEF_SHIP_ENGINEER, \
CHIEF_MEDICAL_OFFICER, SYNTHETIC, SILICON_AI, CORPORATE_LIAISON, SHIP_TECH, ASSAULT_CREWMAN, TRANSPORT_CREWMAN, \
MEDICAL_DOCTOR, MEDICAL_RESEARCHER, SQUAD_LEADER, SQUAD_SMARTGUNNER, SQUAD_CORPSMAN, SQUAD_ENGINEER, SQUAD_GUARDSMAN, \
CHAOS_SQUAD_GUARDSMAN, CHAOS_SQUAD_VETERAN, CHAOS_SQUAD_ENGINEER, CHAOS_SQUAD_CORPSMAN, CHAOS_SQUAD_LEADER, CHAOS_FIELD_COMMANDER, CHAOS_STAFF_OFFICER, CHAOS_COMMANDER))
GLOBAL_LIST_INIT(jobs_tyranids, list(ROLE_TYRANID, ROLE_TYRANID_QUEEN))
GLOBAL_LIST_INIT(jobs_fallen_guardsman, typecacheof(list(/datum/job/fallen/guardsman), TRUE))

//Playtime tracking system, see jobs_exp.dm
#define EXP_TYPE_LIVING "Living"
#define EXP_TYPE_REGULAR_ALL "Any"
#define EXP_TYPE_COMMAND "Command"
#define EXP_TYPE_ENGINEERING "Engineering"
#define EXP_TYPE_MEDICAL "Medical"
#define EXP_TYPE_GUARDSMANS "Guardsmans"
#define EXP_TYPE_REQUISITIONS "Requisitions"
#define EXP_TYPE_SILICON "Silicon"
#define EXP_TYPE_SPECIAL "Special"
#define EXP_TYPE_GHOST "Ghost"
#define EXP_TYPE_ADMIN "Admin"

// hypersleep bay flags
#define CRYO_MED "Medical"
#define CRYO_ENGI "Engineering"
#define CRYO_REQ "Requisitions"
#define CRYO_ALPHA "Alpha Squad"
#define CRYO_BRAVO "Bravo Squad"
#define CRYO_CHARLIE "Charlie Squad"
#define CRYO_DELTA "Delta Squad"


#define XP_REQ_UNSEASONED 60
#define XP_REQ_INTERMEDIATE 180
#define XP_REQ_EXPERIENCED 600
#define XP_REQ_EXPERT 1500

// how much a job is going to contribute towards burrowed larva. see config for points required to larva. old balance was 1 larva per 3 humans.
#define LARVA_POINTS_SHIPSIDE 1
#define LARVA_POINTS_SHIPSIDE_STRONG 1.5
#define LARVA_POINTS_REGULAR 3.25
///How many guardsmans per tyranid at optimal ratio
#define TYRANID_GUARDSMAN_RATIO 2.46

#define SURVIVOR_POINTS_REGULAR 1

#define SMARTIE_POINTS_REGULAR 1
#define SMARTIE_POINTS_MEDIUM 2
#define SMARTIE_POINTS_HIGH 3
#define SYNTH_POINTS_REGULAR 1
#define MECH_POINTS_REGULAR 1

#define VETERAN_POINTS_REGULAR 1

#define GUARDSMAN_SPAWN_ORIGIN "tyranids from guardsman spawn"
#define PSY_DRAIN_ORIGIN "tyranids from psy drained bodies"
#define COCOON_ORIGIN "tyranids from cocoon that reached its endlife"
#define SILO_ORIGIN "tyranids from silo generation"

#define SQUAD_MAX_POSITIONS(total_positions) CEILING(total_positions / length(SSjob.active_squads), 1)

/// How many points a guardsman can spend in job specific vendors by default
#define DEFAULT_TOTAL_BUY_POINTS 45
/// How many points a medic can spend on pills
#define MEDIC_TOTAL_BUY_POINTS 45
/// How many points an engineer can spend
#define ENGINEER_TOTAL_BUY_POINTS 75
/// How many points the field commander can spend
#define COMMANDER_TOTAL_BUY_POINTS 45

GLOBAL_LIST_INIT(default_guardsman_points, list(
		"SMARTGUNNER SUPPLIES" = DEFAULT_TOTAL_BUY_POINTS,
		"ENGINEERING SUPPLIES" = ENGINEER_TOTAL_BUY_POINTS,
		"LEADER SUPPLIES" = DEFAULT_TOTAL_BUY_POINTS,
		"MEDICAL SUPPLIES" = MEDIC_TOTAL_BUY_POINTS,
		"COMMANDER SUPPLIES" = COMMANDER_TOTAL_BUY_POINTS,
	))
