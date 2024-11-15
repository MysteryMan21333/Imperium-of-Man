//Alarm levels.
#define ALARM_WARNING_FIRE (1<<0)
#define ALARM_WARNING_ATMOS (1<<1)
#define ALARM_WARNING_EVAC (1<<2)
#define ALARM_WARNING_READY (1<<3)
#define ALARM_WARNING_DOWN (1<<4)

//area_flags
///When present prevents tyranids from weeding this area
#define DISALLOW_WEEDING (1<<0)
///When present, monitor will consider guardsmans inside it to be at FOB
#define NEAR_FOB (1<<1)
///When present, this will prevent the drop pod to land there (usually kill zones)
#define NO_DROPPOD (1<<2)
///Make this area immune to cas/ob laser. Explosions can still go through if the ob is called in a nearby area
#define OB_CAS_IMMUNE (1<<3)
///Prevent wraith from portaling there, and hivemind to weed there when shutters are closed
#define GUARDSMAN_BASE (1<<4)
///radio works even underground
#define ALWAYS_RADIO (1<<5)
///prevents construction in area
#define NO_CONSTRUCTION (1<<6)
///Disallows nuke timer to be activated in area
#define CANNOT_NUKE (1<<7)

#define AREA_FLAVOR_NONE "area_regular"
#define AREA_FLAVOR_URBAN "area_urban"
