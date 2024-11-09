/datum/emote/living/carbon/tyranid
	mob_type_allowed_typecache = /mob/living/carbon/tyranid


/datum/emote/living/carbon/tyranid/growl
	key = "growl"
	key_third_person = "growls"
	message = "growls!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/alien/growl1.ogg'


/datum/emote/living/carbon/tyranid/growl/one
	key = "growl1"
	sound = 'sound/voice/alien/growl1.ogg'


/datum/emote/living/carbon/tyranid/growl/two
	key = "growl2"
	sound = 'sound/voice/alien/growl2.ogg'


/datum/emote/living/carbon/tyranid/growl/three
	key = "growl3"
	sound = 'sound/voice/alien/growl3.ogg'


/datum/emote/living/carbon/tyranid/hiss
	key = "hiss"
	key_third_person = "hisses"
	message = "hisses!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/alien/hiss1.ogg'


/datum/emote/living/carbon/tyranid/hiss/one
	key = "hiss1"
	sound = 'sound/voice/alien/hiss1.ogg'


/datum/emote/living/carbon/tyranid/hiss/two
	key = "hiss2"
	sound = 'sound/voice/alien/hiss2.ogg'


/datum/emote/living/carbon/tyranid/hiss/three
	key = "hiss3"
	sound = 'sound/voice/alien/hiss3.ogg'


/datum/emote/living/carbon/tyranid/needhelp
	key = "needhelp"
	key_third_person = "needshelp"
	message = "needs help!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/alien/help1.ogg'


/datum/emote/living/carbon/tyranid/needhelp/one
	key = "needhelp1"
	sound = 'sound/voice/alien/help1.ogg'


/datum/emote/living/carbon/tyranid/needhelp/two
	key = "needhelp2"
	sound = 'sound/voice/alien/help2.ogg'


/datum/emote/living/carbon/tyranid/roar
	key = "roar"
	key_third_person = "roars"
	message = "roars!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/voice/alien/roar1.ogg'


/datum/emote/living/carbon/tyranid/roar/one
	key = "roar1"
	sound = 'sound/voice/alien/roar1.ogg'


/datum/emote/living/carbon/tyranid/roar/two
	key = "roar2"
	sound = 'sound/voice/alien/roar2.ogg'


/datum/emote/living/carbon/tyranid/roar/three
	key = "roar3"
	sound = 'sound/voice/alien/roar3.ogg'


/datum/emote/living/carbon/tyranid/roar/four
	key = "roar4"
	sound = 'sound/voice/alien/roar4.ogg'


/datum/emote/living/carbon/tyranid/roar/five
	key = "roar5"
	sound = 'sound/voice/alien/roar5.ogg'


/datum/emote/living/carbon/tyranid/roar/six
	key = "roar6"
	sound = 'sound/voice/alien/roar6.ogg'


/datum/emote/living/carbon/tyranid/tail
	key = "tail"
	key_third_person = "tailsweeps"
	message = "swipes its tail."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/alien/tail_swipe1.ogg'


/datum/emote/living/carbon/tyranid/tail/one
	key = "tail1"
	sound = 'sound/effects/alien/tail_swipe1.ogg'


/datum/emote/living/carbon/tyranid/tail/two
	key = "tail2"
	sound = 'sound/effects/alien/tail_swipe2.ogg'


/datum/emote/living/carbon/tyranid/tail/three
	key = "tail3"
	sound = 'sound/effects/alien/tail_swipe3.ogg'


/datum/emote/living/carbon/tyranid/run_emote(mob/user, params, type_override, intentional = FALSE, prefix)
	if(istype(user, /mob/living/carbon/tyranid/larva))
		playsound(user.loc, SFX_ALIEN_ROAR_LARVA, 15)
	else
		return ..()
