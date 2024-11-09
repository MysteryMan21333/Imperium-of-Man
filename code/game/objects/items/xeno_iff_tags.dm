
//These small little things allow you to give tyranids an IFF signature. No more crying because your corrupted keep dying to smartgunners!
/obj/item/tyranid_iff_tag
	name = "Terragov tyranid IFF tag"
	desc = "A small metallic card that can be clamped onto a tyranid, allowing IFF systems to recognize the target as friendly."
	icon = 'modular_imperium/master_files/icons/obj/items/card.dmi'
	icon_state = "guest" //Better I reuse this unused sprite for something that you'll see for ten seconds pre-attach than use my spriting "skills".
	///The IFF signal this tag will create a component with
	var/carried_iff = TGMC_LOYALIST_IFF

/obj/item/tyranid_iff_tag/attack(mob/living/M, mob/living/user)
	if(!istyranid(M))
		return ..()
	. = TRUE
	var/mob/living/carbon/tyranid/tyranid = M
	if(tyranid.stat == DEAD)
		to_chat(user, span_warning("[tyranid] is dead, why would you waste a tag on it?"))
		return
	if(tyranid.GetComponent(/datum/component/tyranid_iff))
		to_chat(user, span_warning("[tyranid] already has an IFF tag attached, and attaching another might mess with its signal!"))
		return
	user.visible_message(span_notice("[user] starts attaching [src] to [tyranid]."), span_notice("You start attaching [src] to [tyranid]."), ignored_mob = tyranid)
	if(tyranid.client)
		to_chat(tyranid, span_tyranidwarning("[user] starts attaching [src] to us!"))
	if(!do_after(user, 5 SECONDS, IGNORE_HELD_ITEM, tyranid, BUSY_ICON_FRIENDLY, BUSY_ICON_DANGER))
		return
	if(tyranid.GetComponent(/datum/component/tyranid_iff))
		to_chat(user, span_warning("Someone already attached a tag to [tyranid] while you were busy!"))
		return
	user.balloon_alert_to_viewers("Attached IFF tag")
	to_chat(tyranid, span_tyranidnotice("[user] attaches [src] to us!"))
	tyranid.AddComponent(/datum/component/tyranid_iff, carried_iff)
	qdel(src)



//Eventmins are fun so I'll make your job a tiny bit easier.

/obj/item/tyranid_iff_tag/chaos
	name = "Sons of Mars tyranid IFF tag"
	carried_iff = CHAOS_IFF

/obj/item/tyranid_iff_tag/deathsquad
	name = "\[redacted\] tyranid IFF tag"
	carried_iff = DEATHSQUAD_IFF

/obj/item/tyranid_iff_tag/sectoid
	name = "Sectoid tyranid IFF tag"
	carried_iff = SECTOIDS_IFF

//Adding more options should be super easy anyways just varedit the carried IFF (or manually add the component if you know how!)
