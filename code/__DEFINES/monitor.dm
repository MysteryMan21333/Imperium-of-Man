//The different states possible
#define TYRANIDS_LOSING -1
#define TYRANIDS_DELAYING -2
#define STATE_BALANCED 0
#define GUARDSMANS_LOSING 1
#define GUARDSMANS_DELAYING 2

//The threshold to get to those state, after correction from number of players
#define TYRANIDS_DELAYING_THRESHOLD 40
#define TYRANIDS_LOSING_THRESHOLD 20
#define GUARDSMANS_LOSING_THRESHOLD -20
#define GUARDSMANS_DELAYING_THRESHOLD -40

//How many times we must see the same state to consider the situation a stalemate
#define STALEMATE_THRESHOLD 5

//We consider that guardsmans are FOB hugging if 80% of them are in LZ for 3 consecutive state checks
#define PROPORTION_GUARDSMAN_FOB_HUGGING_THRESHOLD 0.8
#define CONSECUTIVE_FOb_HUGGING 3

//The differente gamestate
#define SHUTTERS_CLOSED "shutters closed"
#define GROUNDSIDE "groundside"
#define SHIPSIDE "shipside"

//The weight of each statistics in the state calculator when GROUNDSIDE
#define TYRANIDS_LIFE_WEIGHT -180
#define HUMAN_LIFE_ON_GROUND_WEIGHT 100
#define HUMAN_LIFE_ON_SHIP_WEIGHT 70
#define BURROWED_LARVA_WEIGHT -20
#define REQ_POINTS_WEIGHT 0.2
#define NORMAL_T2_WEIGHT -40
#define PRIMO_T2_WEIGHT -60
#define NORMAL_T3_WEIGHT -60
#define PRIMO_T3_WEIGHT -100
#define NORMAL_T4_WEIGHT -80
#define PRIMO_T4_WEIGHT -120
#define SPAWNING_POOL_WEIGHT -100

//The weight of each statistics in the state calculator before shutters drop
#define TYRANIDS_LIFE_WEIGHT_PREGAME -300
#define HUMAN_LIFE_WEIGHT_PREGAME 100

//The weight of each statistics in the state calculator when shipside
#define TYRANIDS_LIFE_WEIGHT_SHIPSIDE -200
#define HUMAN_LIFE_WEIGHT_SHIPSIDE 100

//Minimum proportion of burrowed larvas compared to live tyranids for the unbalance join detector to show up
#define TOO_MUCH_BURROWED_PROPORTION 0.2

///How much tyranid stats (health, damage and recov) are buffed
GLOBAL_VAR_INIT(tyranid_stat_multiplicator_buff, 1)

///50% is the maximum buff that tyranid can receive
#define MAXIMUM_TYRANID_BUFF_POSSIBLE 1.5

#define MAX_SPAWNABLE_MOB_PER_PLAYER 0.15 //So for 50 players, each spawner can generate 7 mobs
#define SPAWN_RATE_PER_PLAYER 72 //For each player, the time between two consecutive spawns is reduced by 72ticks. So for 35 players, it's one mob every 30 seconds
