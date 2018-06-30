// Code for K unit
/mob/living/simple_animal/hostile/commanded/kunit
	name = "k-unit"
	desc = "K-units are a robotic companions that can follow orders. Designed for security or millitary purposes."
	icon_state = "syndicaterangedpsace"
	icon_living = "syndicaterangedpsace"
	icon_dead = "syndicate_dead" //placeholder, no sprites
	icon_gib = "syndicate_gib" //placeholder, no sprites
	faction = "syndicate"
	var/mob/hostage = null

	// Command vars
	stance = COMMANDED_STOP
	short_name = null
	command_buffer = list()
	known_commands = list("stay", "stop", "attack", "follow", "switch gun", "switch mode", "patrol", "speed")
	master = null //undisputed master. Their commands hold ultimate sway and ultimate power.
	allowed_targets = list() //WHO CAN I KILL D:
	retribution = 1 //whether or not they will attack us if we attack them like some kinda dick.

	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 4
	stop_automated_movement_when_pulled = 0

	// Talking
	speak = list("What's, pal!", "We should be careful!", "Let's see what we have here?","Hmm, maybe I should do something?!")
	speak_emote = "states"
	emote_hear = "states"


	// Health and attack
	attacktext = "punched"
	a_intent = I_HURT
	maxHealth = 200
	health = 200
	harm_intent_damage = 8
	melee_damage_lower = 20
	melee_damage_upper = 25
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
					if(stay_command()) //find a valid command? Stop. Dont try and find more.
						break
				if("stop")
					if(stop_command())
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
				if("patrol")
					if(patrol_command())
						break
				if("speed")
					if(speed_command(speaker, text))
						break
				else
					misc_command(speaker,text) //for specific commands

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
			audible_emote("[emote_hear] \"I got your back, pal!\"",0)
			. = 1
	else if(usr == master)
		. = 1 //already friends, but show success anyways

	else
		to_chat(usr, "<span class='notice'>[src] ignores you.</span>")

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
	else
		..()
	if(ismob(P.firer))
		if (target_mob != P.firer && !(user in friends) && user != master)
			if(P.firer == hostage)
				audible_emote("[emote_hear][" \"This is your warning!\""]")
				target_mob = P.firer
				AttackTarget()
				return
			audible_emote("[emote_hear] \"You know that I am more accurate then you?\"")
			if(attack_mode == "melee")
				switch_mode()
			target_mob = P.firer
			stance = HOSTILE_STANCE_ATTACK
		else if(P.firer == master || P.firer in friends)
			target_mob = null
			stance = HOSTILE_STANCE_IDLE
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
			to_chat(user, "<span class='warning'>This weapon is ineffective, it does no damage.</span>")
			visible_message("<span class='warning'>[user] gently taps [src] with the [O].</span>")
	else
		..()
	if(target_mob != user && !(user in friends) && user != master)
		if(user == hostage)
			audible_emote("[emote_hear] \"This is your warning!\"")
			target_mob = user
			AttackTarget()
			return
		if(ranged)
			audible_emote("[emote_hear] \"I am excellent in hand combat\"")
			switch_mode()
		attacktext = "slashed"
		target_mob = user
		stance = HOSTILE_STANCE_ATTACK
	else if(user == master || user in friends)
		target_mob = null
		stance = HOSTILE_STANCE_IDLE

/mob/living/simple_animal/hostile/commanded/kunit/hitby(atom/movable/AM as mob|obj,var/speed = THROWFORCE_SPEED_DIVISOR)//Standardization and logging -Sieve
	if(istype(AM,/obj/))
		var/obj/O = AM
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
				to_chat(user, "<span class='warning'>This weapon is ineffective, it does no damage.</span>")
				visible_message("<span class='warning'>[user] gently taps [src] with the [O].</span>")

		else
			..()
		if(ismob(O.thrower))
			if((target_mob != O.thrower) && !(user in friends) && user != master)
				if(O.thrower == hostage)
					audible_emote("[emote_hear] \"This is your warning!\"")
					target_mob = O.thrower
					AttackTarget()
					return
				audible_emote("[emote_hear] \"You wanna juggle things with me?!\"")
				target_mob = O.thrower
				stance = HOSTILE_STANCE_ATTACK
			else if(O.thrower == master || O.thrower in friends)
				target_mob = null
				stance = HOSTILE_STANCE_IDLE
	else
		..()


/mob/living/simple_animal/hostile/commanded/kunit/attack_generic(var/mob/user, var/damage, var/attack_message)
	if(shield)
		visible_message("<span class='danger'>[src] pushes [user] back with its shield!</span>")
		return
	else
		..()

	if(target_mob != user && !(user in friends) && user != master)
		if(user == hostage)
			audible_emote("[emote_hear] \"This is your warning!\"")
			target_mob = user
			AttackTarget()
			return 1
		target_mob = user
		stance = HOSTILE_STANCE_ATTACK
	else if(user == master || user in friends)
		target_mob = null
		stance = HOSTILE_STANCE_IDLE

/mob/living/simple_animal/hostile/commanded/kunit/attack_hand(mob/living/carbon/human/M as mob)
	if(shield)
		visible_message("<span class='danger'>[src] pushes [M] back with its shield!</span>")
	else
		..()
	if(target_mob != M && !(user in friends) &&  user != master)
		if(M == hostage)
			audible_emote("[emote_hear] \"This is your warning!\"")
			target_mob = M
			AttackTarget()
			return
		audible_emote("[emote_hear] \"Hey, don't touch me asshole!\"")
		target_mob = M
		stance = HOSTILE_STANCE_ATTACK
	else if(user == master || user in friends)
		target_mob = null
		stance = HOSTILE_STANCE_IDLE

////////////////////////////////
////////////COMMANDS////////////
////////////////////////////////

	// Proc that switches guns between bullets burst rifle and laser rifle.
/mob/living/simple_animal/hostile/commanded/kunit/proc/switch_gun()
	if(!ranged)
		audible_emote("[emote_hear]["Sorry pal, I am in melee mode!"]")
		return 0
	weapon2 = null
	shield = FALSE
	ranged = 1
	if(gun_type == "laser")
		visible_message("<span class='warning'>[src] Switches his gun from laser rifle to an automatic c20r</span>")
		weapon1 = /obj/item/weapon/gun/projectile/automatic/c20r
		casingtype = /obj/item/ammo_casing/t40
		projectilesound = 'sound/weapons/Gunshot_light.ogg'
		projectiletype = /obj/item/projectile/bullet/pistol/medium
		rapid = 1
		gun_type = "bullets"
		update_icon()
	else
		visible_message("<span class='warning'>[src] Switches his gun from automatic c20r to laser rifle</span>")
		weapon1 = /obj/item/weapon/gun/energy/laser
		casingtype = null
		projectilesound = 'sound/weapons/Laser.ogg'
		projectiletype = /obj/item/projectile/beam/midlaser
		rapid = 0
		gun_type = "laser"
		update_icon()
	return 1

/mob/living/simple_animal/hostile/commanded/kunit/proc/pull_gun()
	weapon2 = null
	shield = FALSE
	ranged = 1
	if(gun_type == "bullets")
		visible_message("<span class='warning'>[src] Pulls out c20r from internal storage</span>")
		weapon1 = /obj/item/weapon/gun/projectile/automatic/c20r
		casingtype = /obj/item/ammo_casing/t40
		projectilesound = 'sound/weapons/Gunshot_light.ogg'
		projectiletype = /obj/item/projectile/bullet/pistol/medium
		rapid = 1
		update_icon()
	else
		visible_message("<span class='warning'>[src] Pulls out laser rifle from internal storage</span>")
		weapon1 = /obj/item/weapon/gun/energy/laser
		casingtype = null
		projectilesound = 'sound/weapons/Laser.ogg'
		projectiletype = /obj/item/projectile/beam/midlaser
		rapid = 0
		update_icon()
	return 1

	// Proce that switches attack mode from melee to range and vice versa.
/mob/living/simple_animal/hostile/commanded/kunit/proc/switch_mode()
	if(!ranged)
		visible_message("<span class='warning'>[src] Retracts back energy shield and sword, putting them away.3 </span>")
		pull_gun()
		icon_state = "syndicaterangedpsace"
		attack_mode = "ranged"
		update_icon()
	else
		visible_message("<span class='warning'>[src] Puts his gun into integrated storage and grabs in one hand energy sword, and another energy shield</span>")
		ranged = 0
		weapon1 = /obj/item/weapon/melee/energy/sword/red
		weapon2 = /obj/item/weapon/shield/energy
		shield = TRUE
		icon_state = "syndicatemeleespace"
		attack_mode = "melee"
		update_icon()
	return 1

/mob/living/simple_animal/hostile/commanded/kunit/attack_command(var/mob/speaker, var/text)
	target_mob = null //want me to attack something? Well I better forget my old target.
	walk_to(src,0)
	stance = HOSTILE_STANCE_ATTACK
	if(text == "attack" || findtext(text,"everyone") || findtext(text,"anybody") || findtext(text, "somebody") || findtext(text, "someone")) //if its just 'attack' then just attack anybody, same for if they say 'everyone', somebody, anybody. Assuming non-pickiness.
		allowed_targets = list("everyone")//everyone? EVERYONE
		return 1

	var/list/T = get_targets_by_name(text, filter_friendlies = 1)
	allowed_targets += T
	speed = 8
	move_to_delay = 4
	audible_emote("Roger, attacking [T[1]], in [attack_mode] mode")
	return T.len != 0

/mob/living/simple_animal/hostile/commanded/kunit/follow_command(var/mob/speaker, var/text)
	//we can assume 'stop following' is handled by stop_command
	if(findtext(text,"me"))
		stance = COMMANDED_FOLLOW
		target_mob = speaker //this wont bite me in the ass later.
		audible_emote("[emote_hear] \"Following you, boss!\"")
		return 1
	var/list/targets = get_targets_by_name(text)
	if(targets.len > 1 || !targets.len) //CONFUSED. WHO DO I FOLLOW?
		return 0

	speed = 6
	move_to_delay = 3
	audible_emote("[emote_hear] \"Roger that, following [targets[1]]\"")
	stance = COMMANDED_FOLLOW //GOT SOMEBODY. BETTER FOLLOW EM.
	target_mob = targets[1] //YEAH GOOD IDEA

	return 1

/mob/living/simple_animal/hostile/commanded/kunit/stay_command()
	target_mob = null
	stance = COMMANDED_STOP
	stop_automated_movement = 1
	walk_to(src,0)
	audible_emote("[emote_hear] \"Roger that, staying here\"")
	return 1

/mob/living/simple_animal/hostile/commanded/kunit/proc/patrol_command()
	target_mob = null
	stance = HOSTILE_STANCE_IDLE
	stop_automated_movement = 0
	walk_to(src,0)
	audible_emote("[emote_hear] \"Roger that, patrolling the area\"")
	return 1

/mob/living/simple_animal/hostile/commanded/kunit/stop_command()
	allowed_targets = list()
	walk_to(src,0)
	target_mob = null //gotta stop SOMETHIN
	stance = HOSTILE_STANCE_IDLE
	stop_automated_movement = 0
	audible_emote("[emote_hear] \"Alright, I will stop\"")
	return 1

// We can be slow, average, fast.
/mob/living/simple_animal/hostile/commanded/kunit/proc/speed_command(var/mob/speaker, var/text)
	if(findtext(text,"slow"))
		speed = 4
		move_to_delay = 4
		audible_emote("[emote_hear] \"Setting acutators speed to slow\"")
	else if(findtext(text,"average"))
		speed = 6
		move_to_delay = 3
		audible_emote("[emote_hear] \"Setting acutators speed to balanced\"")
	else if(findtext(text,"fast"))
		speed = 8
		move_to_delay = 2
		audible_emote("[emote_hear] \"Setting acutators speed to fast\"")
	else
		speed = 6
		audible_emote("[emote_hear] \"Sorry pal, but I did not understand speed setting. Setting acutators speed to balanced.\"")
	return 1

////////////////////////////////
////////////BACK-END////////////
////////////////////////////////

/mob/living/simple_animal/hostile/commanded/kunit/MoveToTarget()
	stop_automated_movement = 1
	if(QDELETED(target_mob) || SA_attackable(target_mob))
		LoseTarget()
	if(target_mob in targets)
		if(ranged)
			if(get_dist(src, target_mob) >= 9)
				walk_to(src, target_mob, 1, move_to_delay)
			else
				stance = HOSTILE_STANCE_ATTACKING
		else
			stance = HOSTILE_STANCE_ATTACKING
			walk_to(src, target_mob, 1, move_to_delay)

/mob/living/simple_animal/hostile/commanded/kunit/AttackTarget()

	stop_automated_movement = 1
	if(QDELETED(target_mob) || SA_attackable(target_mob))
		LoseTarget()
		return 0
	if(!(target_mob in targets))
		LoseTarget()
		return 0
	if(next_move >= world.time)
		return 0
	if(!ranged)
		if(get_dist(src, target_mob) <= 1)	//Attacking
			AttackingTarget()
			attacked_times += 1
			return 1
	else
		if(get_dist(src, target_mob) <= 9)
			OpenFire(target_mob)
			attacked_times += 1
			return 1

/mob/living/simple_animal/hostile/commanded/kunit/AttackingTarget()
	setClickCooldown(attack_delay)
	if(!Adjacent(target_mob))
		return
	if(isliving(target_mob))
		var/mob/living/L = target_mob
		L.attack_generic(src,rand(melee_damage_lower,melee_damage_upper),attacktext)
		return L
	if(istype(target_mob,/obj/mecha))
		var/obj/mecha/M = target_mob
		M.attack_generic(src,rand(melee_damage_lower,melee_damage_upper),attacktext)
		return M
	if(istype(target_mob,/obj/machinery/bot))
		var/obj/machinery/bot/B = target_mob
		B.attack_generic(src,rand(melee_damage_lower,melee_damage_upper),attacktext)
		return B

