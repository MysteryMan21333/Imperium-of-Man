/mob/living/carbon/tyranid/beetle/ai

/mob/living/carbon/tyranid/beetle/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid/suicidal)

/mob/living/carbon/tyranid/baneling/ai

/mob/living/carbon/tyranid/baneling/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid/suicidal)

/mob/living/carbon/tyranid/crusher/ai

/mob/living/carbon/tyranid/crusher/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/defender/ai

/mob/living/carbon/tyranid/defender/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/drone/ai

/mob/living/carbon/tyranid/drone/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/hivelord/ai

/mob/living/carbon/tyranid/hivelord/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/hunter/ai

/mob/living/carbon/tyranid/hunter/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/praetorian/ai

/mob/living/carbon/tyranid/praetorian/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid/ranged)

/mob/living/carbon/tyranid/queen/ai

/mob/living/carbon/tyranid/queen/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/mantis/ai

/mob/living/carbon/tyranid/mantis/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid/suicidal)

/mob/living/carbon/tyranid/ravager/ai

/mob/living/carbon/tyranid/ravager/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/runner/ai

/mob/living/carbon/tyranid/runner/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/scorpion/ai

/mob/living/carbon/tyranid/scorpion/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid/ranged)

/mob/living/carbon/tyranid/sentinel/ai

/mob/living/carbon/tyranid/sentinel/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid/ranged)

/mob/living/carbon/tyranid/spitter/ai

/mob/living/carbon/tyranid/spitter/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid/ranged)

/mob/living/carbon/tyranid/warrior/ai

/mob/living/carbon/tyranid/warrior/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/boiler/ai

/mob/living/carbon/tyranid/boiler/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)

/mob/living/carbon/tyranid/nymph/ai

/mob/living/carbon/tyranid/nymph/ai/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/tyranid)
