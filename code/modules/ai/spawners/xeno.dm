/obj/effect/ai_node/spawner/tyranid
	name = "Tyranid AI spawner"

//////Generic tyranid spawners
////////Tier ones

/obj/effect/ai_node/spawner/tyranid/runnergang	// RUNNNER GANG RUNNER GANG
	spawntypes = /mob/living/carbon/tyranid/runner/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/defender
	spawntypes = /mob/living/carbon/tyranid/defender/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/sentinel
	spawntypes = /mob/living/carbon/tyranid/sentinel/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/drone
	spawntypes = /mob/living/carbon/tyranid/drone/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/tierones
	spawntypes = list(/mob/living/carbon/tyranid/runner/ai, /mob/living/carbon/tyranid/sentinel/ai, /mob/living/carbon/tyranid/defender/ai, /mob/living/carbon/tyranid/drone/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/////////////Tier twos

/obj/effect/ai_node/spawner/tyranid/spitter
	spawntypes = /mob/living/carbon/tyranid/spitter/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/warrior
	spawntypes = /mob/living/carbon/tyranid/warrior/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/hivelord
	spawntypes = /mob/living/carbon/tyranid/hivelord/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/hunter
	spawntypes = /mob/living/carbon/tyranid/hunter/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/tiertwos
	spawntypes = list(/mob/living/carbon/tyranid/hunter/ai, /mob/living/carbon/tyranid/warrior/ai, /mob/living/carbon/tyranid/spitter/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

////////////////////Tier 3s

/obj/effect/ai_node/spawner/tyranid/ravager
	spawntypes = /mob/living/carbon/tyranid/ravager/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/boiler
	spawntypes = /mob/living/carbon/tyranid/boiler/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/praetorian
	spawntypes = /mob/living/carbon/tyranid/praetorian/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/tyranid/crusher
	spawntypes = /mob/living/carbon/tyranid/crusher/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10


/obj/effect/ai_node/spawner/tyranid/tierthrees
	spawntypes = list(/mob/living/carbon/tyranid/crusher/ai, /mob/living/carbon/tyranid/praetorian/ai, /mob/living/carbon/tyranid/boiler/ai, /mob/living/carbon/tyranid/ravager/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/////////////Tier 4s

/obj/effect/ai_node/spawner/tyranid/queen
	spawntypes = /mob/living/carbon/tyranid/queen/ai
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10
