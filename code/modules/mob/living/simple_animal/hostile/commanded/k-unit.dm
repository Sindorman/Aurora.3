// Code for K unit
/mob/living/simple_animal/hostile/commanded/kunit
	name = "k-unit"
	desc = "K-units are a robotic companions that can follow orders. Designed for security or millitary purposes."
	icon_state = "syndicaterangedpsace"
	icon_living = "syndicaterangedpsace"
	icon_dead = "syndicate_dead" //placeholder, no sprites
	icon_gib = "syndicate_gib" //placeholder, no sprites
	faction = "syndicate"

	// Command vars
	stance = COMMANDED_STOP
	short_name = null
	list/command_buffer = list()
	list/known_commands = list("stay", "stop", "attack", "follow", "switch gun", "switch mode")
	mob/master = null //undisputed master. Their commands hold ultimate sway and ultimate power.
	list/allowed_targets = list() //WHO CAN I KILL D:
	retribution = 1 //whether or not they will attack us if we attack them like some kinda dick.

	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 4
	stop_automated_movement_when_pulled = 0

	// Talking
	speak = list("What's, pal!", "We should be careful!", "Let's see what we have here?","Hmm, maybe I should do something?!")
	speak_emote = list("states")
	emote_hear = list("states")


	// Health and attack
	attacktext = "punched"
	a_intent = I_HURT
	maxHealth = 200
	health = 200
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	melee_damage_lower = 0
	melee_damage_upper = 0
	density = 0
	var/shield = FALSE
	var/attack_mode = "ranged"

	// Gun vars
	var/weapon1 = /obj/item/weapon/gun/projectile/automatic/c20r
	var/weapon2 = null
	ranged = 1
	rapid = 1
	var/gun_type = "bullets"

	casingtype = /obj/item/ammo_casing/t40
	projectilesound = 'sound/weapons/Gunshot_light.ogg'
	projectiletype = /obj/item/projectile/bullet/pistol/medium

	// Misc
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	unsuitable_atoms_damage = 15
	turns_per_move = 5

	status_flags = CANPUSH

	tameable = FALSE

/mob/living/simple_animal/hostile/commanded/kunit/Initialize()
	..()
	if(!short_name)
		short_name = name

/mob/living/simple_animal/hostile/commanded/kunit/listen(var/mob/speaker, var/text)
	for(var/command in known_commands)
		if(findtext(text,command))
			switch(command)
				if("stay")
					if(stay_command(speaker,text)) //find a valid command? Stop. Dont try and find more.
						break
				if("stop")
					if(stop_command(speaker,text))
						break
				if("attack")
					if(attack_command(speaker,text))
						break
				if("follow")
					if(follow_command(speaker,text))
						break
				if("switch gun")
					if(switch_gun())
						break
				if("switch mode")
					if(switch_mode())
						break
				else
					misc_command(speaker,text) //for specific commands

	return 1



	if(emote_hear && emote_hear.len)
		audible_emote("[pick(emote_hear)].",0)
	stance = COMMANDED_FOLLOW //GOT SOMEBODY. BETTER FOLLOW EM.
	target_mob = targets[1] //YEAH GOOD IDEA

	return 1

// For testing
/mob/living/simple_animal/hostile/commanded/kunit/verb/befriend()
	set name = "Befriend K-Unit"
	set category = "IC"
	set src in view(1)

	if(!master)
		var/mob/living/carbon/human/H = usr
		if(istype(H))
			master = usr
			audible_emote("states \"I got your back, pal!\"",0)
			. = 1
	else if(usr == master)
		. = 1 //already friends, but show success anyways

	else
		usr << "<span class='notice'>[src] ignores you.</span>"

	return

////////////////////////////////
////////////ATTACKED////////////
////////////////////////////////

/mob/living/simple_animal/hostile/commanded/kunit/bullet_act(var/obj/item/projectile/P, var/def_zone)
	if(!P)	return
	if(shield)
		if(prob(65))
			src.health -= P.damage
		else
			visible_message("<span class='danger'>[src] blocks [P] with its shield!</span>")

	if (ismob(P.firer) && target_mob != P.firer && !(user in friends))
		audible_emote("You know that I am more accurate then you?")
		switch_gun()
		target_mob = P.firer
		stance = HOSTILE_STANCE_ATTACK
	return 0

/mob/living/simple_animal/hostile/commanded/kunit/attackby(var/obj/item/O, var/mob/user)
	if(shield)
		if(O.force)
			if(prob(80))
				var/damage = O.force
				if (O.damtype == HALLOSS)
					damage = 0
				health -= damage
				visible_message("<span class='danger'>[src] has been attacked with the [O] by [user].</span>")
			else
				visible_message("<span class='danger'>[src] blocks the [O] with its shield!</span>")
			//user.do_attack_animation(src)
		else
			usr << "<span class='warning'>This weapon is ineffective, it does no damage.</span>"
			visible_message("<span class='warning'>[user] gently taps [src] with the [O].</span>")
	if(target_mob != user && !(user in friends))
		if(!shield)
			audible_emote("I am excellent in hand combat")
			visible_message("<span class='danger'>[src] Put his gun into integrated storage and grabs in one hand energt sword, and another energy shield</span>")
			switch_mode()
		attacktext = "slashed"
		target_mob = user
		stance = HOSTILE_STANCE_ATTACK

/mob/living/simple_animal/hostile/commanded/kunit/hitby(atom/movable/AM as mob|obj,var/speed = THROWFORCE_SPEED_DIVISOR)//Standardization and logging -Sieve
	..()
	if(istype(AM,/obj/))
		var/obj/O = AM
		if((target_mob != O.thrower) && ismob(O.thrower) && !(user in friends))
			audible_emote("You wanna juggle things with me?!")
			target_mob = O.thrower
			stance = HOSTILE_STANCE_ATTACK

/mob/living/simple_animal/hostile/commanded/kunit/attack_generic(var/mob/user, var/damage, var/attack_message)
	..()
	if(target_mob != user && !(user in friends))
		target_mob = user
		stance = HOSTILE_STANCE_ATTACK

/mob/living/simple_animal/hostile/commanded/kunit/attack_hand(mob/living/carbon/human/M as mob)
	..()
	if(target_mob != M && !(user in friends))
		audible_emote("Hey, don't touch me asshole!")
		target_mob = M
		stance = HOSTILE_STANCE_ATTACK

////////////////////////////////
////////////COMMANDS////////////
////////////////////////////////

	// Proc that switches guns between bullets burst rifle and laser rifle.
/mob/living/simple_animal/hostile/commanded/kunit/proc/switch_gun()
	weapon2 = null
	shield = FALSE
	ranged = 1
	if(gun_type == "bullets")
		weapon1 = /obj/item/weapon/gun/projectile/automatic/c20r
		casingtype = /obj/item/ammo_casing/t40
		projectilesound = 'sound/weapons/Gunshot_light.ogg'
		projectiletype = /obj/item/projectile/bullet/pistol/medium
		rapid = 1
	else
		weapon1 = /obj/item/weapon/gun/energy/laser
		casingtype = null
		projectilesound = 'sound/weapons/Laser.ogg'
		projectiletype = /obj/item/projectile/beam/midlaser
		rapid = 0
	return 1

	// Proce that switches attack mode from melee to range and vice versa.
/mob/living/simple_animal/hostile/commanded/kunit/proc/switch_mode()
	if(attack_mode == "melee")
		ranged = 1
		switch_gun()
		icon_state = "syndicaterangedpsace"
		attack_mode = "ranged"
		update_icon()

	else
		ranged = 0
		weapon1 = /obj/item/weapon/melee/energy/sword/red
		weapon2 = /obj/item/weapon/shield/energy
		shield = TRUE
		icon_state = "syndicatemeleespace"
		attack_mode = "melee"
		update_icon()
	return 1

/mob/living/simple_animal/hostile/commanded/kunit/attack_command(var/mob/speaker,var/text)
	target_mob = null //want me to attack something? Well I better forget my old target.
	walk_to(src,0)
	stance = HOSTILE_STANCE_IDLE
	if(text == "attack" || findtext(text,"everyone") || findtext(text,"anybody") || findtext(text, "somebody") || findtext(text, "someone")) //if its just 'attack' then just attack anybody, same for if they say 'everyone', somebody, anybody. Assuming non-pickiness.
		allowed_targets = list("everyone")//everyone? EVERYONE
		return 1

	var/list/T = get_targets_by_name(text, filter_friendlies = 1)
	allowed_targets += T
	if(emote_hear && emote_hear.len)
		audible_emote("[pick(emote_hear)].",0)
	return T.len != 0