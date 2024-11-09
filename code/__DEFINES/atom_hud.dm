// for secHUDs and medHUDs and variants.
//The number is the location of the image on the list hud_list of humans.
// /datum/atom_hud expects these to be unique
// these need to be strings in order to make them associative lists
#define HEALTH_HUD "health_hud" // a simple line rounding the mob's number health
#define STATUS_HUD_SIMPLE "status_hud_simple" // basic statuses: dead, asleep, knocked out, sluggish, etc.
#define STATUS_HUD "status_hud" // medical hud, shows simple status plus defib stages.
#define WANTED_HUD "wanted_hud" // wanted, released, parroled, security status
#define TYRANID_EMBRYO_HUD "tyranid_embryo_hud" // tyranid larval stage.
#define HEALTH_HUD_TYRANID "tyranid_health_hud" //health HUD for tyranids
#define SQUAD_HUD_IMPERIUM "squad_hud_terragov" //squad hud showing who's leader, corpsman, etc for each squad.
#define SQUAD_HUD_CHAOS "squad_hud_som" //squad hud showing who's leader, corpsman, etc for each squad.
#define PLASMA_HUD "tyranid_plasma_hud" //indicates the plasma level of tyranids.
#define PHEROMONE_HUD "tyranid_pheromone_hud" //indicates which pheromone is active on a tyranid.
#define QUEEN_OVERWATCH_HUD "tyranid_overwatch_hud" //indicates which tyranid the queen is overwatching.
#define TYRANID_RANK_HUD "tyranid_rank_hud" //indicates the current rank of the tyranid
#define ORDER_HUD "human_order_hud" //shows what orders are applied to guardsmans
#define PAIN_HUD "pain_hud" //displays human pain / preceived health.
#define ARMOR_SUNDER_HUD "armor_sunder_hud" //displays how much sunder has been applied.
#define TYRANID_REAGENT_HUD "tyranid_reagent_hud" // displays sign based on reagent in human
#define TYRANID_TACTICAL_HUD "tyranid_tactical_hud" // displays tyranid tactical elements such as tunnels and rally hive pings
#define MACHINE_HEALTH_HUD "machine_health_hud" // displays machine health; part of /datum/atom_hud/squad
#define MACHINE_AMMO_HUD "machine_ammo_hud" // displays machine ammo; part of /datum/atom_hud/squad
#define TYRANID_DEBUFF_HUD "tyranid_debuff_hud" // displays tyranid debuffs; part of /datum/atom_hud/tyranid_debuff
#define HEART_STATUS_HUD "heart_status_hud" // display if revivable, along with blood level
#define TYRANID_FIRE_HUD "tyranid_fire_hud" // displays how many fire stacks a tyranid has
#define TYRANID_BLESSING_HUD "tyranid_blessing_hud" //indicates what blessings the tyranid has
#define TYRANID_EVASION_HUD "tyranid_extra_hud" // displays anything extra or additional such as runner's evasion duration

#define ADD_HUD_TO_COOLDOWN 20 //cooldown for being shown the images for any particular data hud

//by default everything in the hud_list of an atom is an image
//a value in hud_list with one of these will change that behavior
#define HUD_LIST_LIST 1


//data HUD defines
#define DATA_HUD_BASIC 1
#define DATA_HUD_SECURITY_ADVANCED 2
#define DATA_HUD_MEDICAL_BASIC 3
#define DATA_HUD_MEDICAL_ADVANCED 4
#define DATA_HUD_MEDICAL_ADVANCED_SYNTH 5
#define DATA_HUD_MEDICAL_OBSERVER 6
#define DATA_HUD_TYRANID_INFECTION 7
#define DATA_HUD_TYRANID_REAGENTS 8
#define DATA_HUD_TYRANID_STATUS 9
#define DATA_HUD_SQUAD_IMPERIUM 10
#define DATA_HUD_ORDER 11
#define DATA_HUD_MEDICAL_PAIN 12
#define DATA_HUD_TYRANID_TACTICAL 13
#define DATA_HUD_SQUAD_CHAOS 14
#define DATA_HUD_TYRANID_DEBUFF 15
#define DATA_HUD_TYRANID_HEART 16


// Notification action types
#define NOTIFY_JUMP "jump"
#define NOTIFY_ATTACK "attack"
#define NOTIFY_ORBIT "orbit"
#define NOTIFY_JOIN_AS_LARVA "join_as_larva"

// AI notify action types
#define NOTIFY_AI_ALERT "aijump"
