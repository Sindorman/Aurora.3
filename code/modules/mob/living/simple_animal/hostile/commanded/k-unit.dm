#define LASER_GUN 0
#define BULLET_GUN 1

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
	command_buffer = list()
	known_commands = list(
							"stay", "stop", "attack", "follow", "switch gun", "switch mode", "patrol", "change speed", "set hostage", "forget hostage", "aggressive mode",
							"passive mode")
	master = null //undisputed master. Their commands hold ultimate sway and ultimate power.
	allowed_targets = list() //WHO CAN I KILL D:
	retribution = 1 //whether or not they will attack us if we attack them like some kinda dick.

	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 4
	stop_automated_movement_when_pulled = 0

	// Talking
	speak = list("What's up, pal!", "We should be careful!", "Let's see what we have here?","Hmm, maybe I should do something?!")
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
	var/attack_hostage = FALSE
	var/distance = null
	var/mob/hostage = null

	// Gun vars
	var/obj/item/weapon/weapon1 = /obj/item/weapon/gun/projectile/automatic/c20r
	var/obj/item/weapon/weapon2 = null
	ranged = 1
	rapid = 1
	var/gun_type = BULLET_GUN
	var/max_ammo = 60 // Max ammo we can have
	var/stored_ammo = 60 // Currently stored in storage
	var/loaded_ammo = 30 // currently loaded in our gun
	var/ammo = TRUE // used to stop from switching guns

	casingtype = /obj/item/ammo_casing/c9mm
	projectilesound = 'sound/weapons/gunshot/gunshot_pistol.ogg'
	projectiletype = /obj/item/projectile/bullet/pistol

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
	var/aggressive_mode = FALSE
	tameable = FALSE

/mob/living/simple_animal/hostile/commanded/kunit/Initialize()
	..()
	if(!short_name)
		short_name = name
	new /obj/item/weapon/gun/projectile/automatic/c20r(src)
	new /obj/item/weapon/gun/energy/laser(src)
	new /obj/item/weapon/melee/energy/sword/red(src)
	new /obj/item/weapon/shield/energy(src)
	zone_sel = new /obj/screen/zone_sel(src)
	zone_sel.selecting = "chest"

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
				if("change speed")
					if(speed_command(speaker, text))
						break
				if("set hostage")
					if(hostage_set(speaker, text))
						break
				if("forget hostage")
					if(hostage_forget())
						break
				if("aggressive mode")
					if(aggressive_mode())
						break
				if("passive mode")
					if(passive_mode())
						break
				else
					misc_command(speaker,text) //for specific commands

	return 1

/mob/living/simple_animal/hostile/commanded/kunit/think()
	..()
	if(!aggressive_mode)
		target_mob = null
		stance = HOSTILE_STANCE_IDLE

// For testing
/mob/living/simple_animal/hostile/commanded/kunit/verb/befriend()
	set name = "Befriend K-Unit"
	set category = "IC"
	set src in view(1)

	if(!master)
		var/mob/living/carbon/human/H = usr
		if(istype(H))
			master = usr
			faction = master.faction
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
		if(prob(60))
			src.health -= P.damage
		else
			visible_message("<span class='danger'>[src] blocks [P] with its shield!</span>")
	else
		..()
	if(ismob(P.firer))
		if(P.firer == master || (P.firer in friends))
			return
		if (target_mob != P.firer)
			if(P.firer == hostage)
				audible_emote("[emote_hear][" \"This is your warning!\""]")
				target_mob = P.firer
				attack_hostage = TRUE
				AttackTarget()
				attack_hostage = FALSE
				target_mob = null
				stance = HOSTILE_STANCE_IDLE
				return

			target_mob = P.firer
			stance = HOSTILE_STANCE_ATTACK
			aggressive_mode = TRUE
		audible_emote("[emote_hear] \"You know that I am more accurate then you?\"")
		if(!ranged)
			switch_mode()
	return 0

/mob/living/simple_animal/hostile/commanded/kunit/attackby(var/obj/item/O, var/mob/user)
	if(shield)
		if(O.force)
			if(prob(20))
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
	if(user == master || (user in friends))
		return
	if(target_mob != user)
		if(user == hostage)
			audible_emote("[emote_hear] \"This is your warning!\"")
			target_mob = user
			attack_hostage = TRUE
			AttackTarget()
			attack_hostage = FALSE
			target_mob = null
			stance = HOSTILE_STANCE_IDLE
			return
		attacktext = "slashed"
		target_mob = user
		stance = HOSTILE_STANCE_ATTACK
		aggressive_mode = TRUE
	if(ranged)
		audible_emote("[emote_hear] \"I am excellent in hand combat\"")
		switch_mode()

/mob/living/simple_animal/hostile/commanded/kunit/hitby(atom/movable/AM as mob|obj,var/speed = THROWFORCE_SPEED_DIVISOR)//Standardization and logging -Sieve
	if(istype(AM,/obj/))
		var/obj/O = AM
		if(shield)
			if(O.force)
				if(prob(10))
					var/damage = O.force
					if (O.damtype == HALLOSS)
						damage = 0
					health -= damage
					visible_message("<span class='danger'>[src] has been attacked with the [O] by [O.thrower].</span>")
				else
					visible_message("<span class='danger'>[src] blocks the [O] with its shield!</span>")
				//user.do_attack_animation(src)
			else
				if(ismob(O.thrower))
					to_chat(O.thrower, "<span class='warning'>This weapon is ineffective, it does no damage.</span>")
					visible_message("<span class='warning'>[O] bounces off shield.</span>")

		else
			..()
		if(ismob(O.thrower))
			if(O.thrower == master || (O.thrower in friends))
				return
			if((target_mob != O.thrower))
				if(O.thrower == hostage)
					audible_emote("[emote_hear] \"This is your warning!\"")
					target_mob = O.thrower
					attack_hostage = TRUE
					AttackTarget()
					attack_hostage = FALSE
					target_mob = null
					stance = HOSTILE_STANCE_IDLE
					return
				audible_emote("[emote_hear] \"You wanna juggle things with me?!\"")
				target_mob = O.thrower
				stance = HOSTILE_STANCE_ATTACK
				aggressive_mode = TRUE
	else
		..()


/mob/living/simple_animal/hostile/commanded/kunit/attack_generic(var/mob/user, var/damage, var/attack_message)
	if(shield)
		visible_message("<span class='danger'>[src] pushes [user] back with its shield!</span>")
		return
	else
		..(user, damage/3, attack_message)
	if(user == master || (user in friends))
		return
	if(target_mob != user)
		if(user == hostage)
			audible_emote("[emote_hear] \"This is your warning!\"")
			target_mob = user
			attack_hostage = TRUE
			AttackTarget()
			attack_hostage = FALSE
			target_mob = null
			stance = HOSTILE_STANCE_IDLE
			return
		target_mob = user
		stance = HOSTILE_STANCE_ATTACK
		aggressive_mode = TRUE
	audible_emote("[emote_hear] \"Hey, don't touch me asshole!\"")
	if(ranged)
		switch_mode()

/mob/living/simple_animal/hostile/commanded/kunit/attack_hand(mob/living/carbon/human/M as mob)
	if(shield)
		visible_message("<span class='danger'>[src] pushes [M] back with its shield!</span>")
	else
		..()
	if(M == master || (M in friends))
		return
	if(target_mob != M)
		if(M == hostage)
			audible_emote("[emote_hear] \"This is your warning!\"")
			target_mob = M
			attack_hostage = TRUE
			AttackTarget()
			attack_hostage = FALSE
			target_mob = null
			stance = HOSTILE_STANCE_IDLE
			return
		target_mob = M
		stance = HOSTILE_STANCE_ATTACK
		aggressive_mode = TRUE
	audible_emote("[emote_hear] \"Hey, don't touch me asshole!\"")
	if(ranged)
		switch_mode()

////////////////////////////////
////////////COMMANDS////////////
////////////////////////////////

/mob/living/simple_animal/hostile/commanded/kunit/proc/aggressive_mode()
	audible_emote("[emote_hear] \"Roger that, aggressive mode initiated!\"")
	aggressive_mode = TRUE
	return TRUE

/mob/living/simple_animal/hostile/commanded/kunit/proc/passive_mode()
	audible_emote("[emote_hear] \"Roger that, passive mode initiated!\"")
	aggressive_mode = FALSE
	return TRUE

	// Proc that switches guns between bullets burst rifle and laser rifle.
/mob/living/simple_animal/hostile/commanded/kunit/proc/switch_gun()
	if(!ranged)
		audible_emote("[emote_hear] \"Sorry pal, I am in melee mode!\"")
		return 1
	if(!ammo && gun_type)
		audible_emote("[emote_hear] \"I have no ammo! Give me some.\"")
		return 1
	weapon2 = null
	shield = FALSE
	ranged = 1
	if(!gun_type)
		visible_message("<span class='warning'>[src] Switches his gun from laser rifle to an automatic c20r</span>")
		weapon1 = locate(/obj/item/weapon/gun/projectile/automatic/c20r, src)
		casingtype = /obj/item/ammo_casing/c10mm
		projectilesound = 'sound/weapons/gunshot/gunshot_pistol.ogg'
		projectiletype = /obj/item/projectile/bullet/pistol
		rapid = 1
		gun_type = BULLET_GUN
		update_icon()
	else
		visible_message("<span class='warning'>[src] Switches his gun from automatic c20r to laser rifle</span>")
		weapon1 = locate(/obj/item/weapon/gun/energy/laser, src)
		casingtype = null
		projectilesound = 'sound/weapons/Laser.ogg'
		projectiletype = /obj/item/projectile/beam/midlaser
		rapid = 0
		gun_type = LASER_GUN
		update_icon()
	return 1

/mob/living/simple_animal/hostile/commanded/kunit/proc/pull_gun()
	weapon2 = null
	shield = FALSE
	ranged = 1
	if(gun_type)
		visible_message("<span class='warning'>[src] Pulls out c20r from internal storage</span>")
		weapon1 = locate(/obj/item/weapon/gun/projectile/automatic/c20r, src)
		casingtype = /obj/item/ammo_casing/c10mm
		projectilesound = 'sound/weapons/gunshot/gunshot_pistol.ogg'
		projectiletype = /obj/item/projectile/bullet/pistol
		rapid = 1
		update_icon()
	else
		visible_message("<span class='warning'>[src] Pulls out laser rifle from internal storage</span>")
		weapon1 = locate(/obj/item/weapon/gun/energy/laser, src)
		casingtype = null
		projectilesound = 'sound/weapons/Laser.ogg'
		projectiletype = /obj/item/projectile/beam/midlaser
		rapid = 0
		update_icon()
	return 1

	// Proc that switches attack mode from melee to range and vice versa.
/mob/living/simple_animal/hostile/commanded/kunit/proc/switch_mode()
	shield = FALSE
	if(!ranged)
		visible_message("<span class='warning'>[src] Retracts back energy shield and sword, putting them away. </span>")
		var/obj/item/weapon/melee/energy/sword/e = weapon1
		e.deactivate(src)
		pull_gun()
		icon_state = "syndicaterangedpsace"
		ranged = TRUE
		update_icon()
		walk_to(src, src, 0, move_to_delay)
	else
		visible_message("<span class='warning'>[src] Puts his gun into integrated storage and grabs in one hand energy sword, and another energy shield</span>")
		ranged = 0
		weapon1 = locate(/obj/item/weapon/melee/energy/sword/red, src)
		weapon2 = locate( /obj/item/weapon/shield/energy, src)
		var/obj/item/weapon/melee/energy/sword/e = weapon1
		shield = TRUE
		icon_state = "syndicatemeleespace"
		ranged = FALSE
		e.activate(src)
		update_icon()
	return 1

/mob/living/simple_animal/hostile/commanded/kunit/proc/hostage_set(var/mob/speaker, var/text)
	var/list/T = get_targets_by_name(text, filter_friendlies = 1)
	if(!T.len)
		audible_emote("[emote_hear] \"What were their names again?\"")
		return FALSE
	hostage = T[1]
	audible_emote("[emote_hear] \"Roger that, I will keep an eye on [hostage]. You asshole don't stand in my way or I might shoot you too.\"")
	return TRUE

/mob/living/simple_animal/hostile/commanded/kunit/proc/hostage_forget()
	audible_emote("[emote_hear] \"[hostage] is nobody to me, boss!\"")
	hostage = null
	return TRUE

/mob/living/simple_animal/hostile/commanded/kunit/attack_command(var/mob/speaker, var/text)
	target_mob = null //want me to attack something? Well I better forget my old target.
	walk_to(src,0)
	stance = HOSTILE_STANCE_ATTACK
	if(text == "attack" || findtext(text,"everyone") || findtext(text,"anybody") || findtext(text, "somebody") || findtext(text, "someone")) //if its just 'attack' then just attack anybody, same for if they say 'everyone', somebody, anybody. Assuming non-pickiness.
		allowed_targets = list("everyone")//everyone? EVERYONE
		return TRUE

	var/list/T = get_targets_by_name(text, filter_friendlies = 1)
	if(!T.len)
		audible_emote("[emote_hear] \"What were their names again?\"")
		return FALSE
	allowed_targets += T
	speed = 8
	move_to_delay = 4
	audible_emote("[emote_hear] \"Roger, attacking [T[1]], in [ranged ? "ranged" : "meleed"] mode\"")
	return T.len != 0

/mob/living/simple_animal/hostile/commanded/kunit/follow_command(var/mob/speaker, var/text)
	//we can assume 'stop following' is handled by stop_command
	if(findtext(text,"me"))
		stance = COMMANDED_FOLLOW
		target_mob = speaker //this wont bite me in the ass later.
		audible_emote("[emote_hear] \"Following you, boss!\"")
		return TRUE
	var/list/targets = get_targets_by_name(text)
	if(targets.len > 1 || !targets.len) //CONFUSED. WHO DO I FOLLOW?
		return FALSE

	speed = 6
	move_to_delay = 3
	audible_emote("[emote_hear] \"Roger that, following [targets[1]]\"")
	stance = COMMANDED_FOLLOW //GOT SOMEBODY. BETTER FOLLOW EM.
	target_mob = targets[1] //YEAH GOOD IDEA

	return TRUE

/mob/living/simple_animal/hostile/commanded/kunit/stay_command()
	target_mob = null
	stance = COMMANDED_STOP
	stop_automated_movement = 1
	walk_to(src,0)
	audible_emote("[emote_hear] \"Roger that, staying here\"")
	return TRUE

/mob/living/simple_animal/hostile/commanded/kunit/proc/patrol_command()
	target_mob = null
	stance = HOSTILE_STANCE_IDLE
	stop_automated_movement = 0
	walk_to(src,0)
	audible_emote("[emote_hear] \"Roger that, patrolling the area\"")
	return TRUE

/mob/living/simple_animal/hostile/commanded/kunit/stop_command()
	allowed_targets = list()
	walk_to(src,0)
	target_mob = null //gotta stop SOMETHIN
	stance = HOSTILE_STANCE_IDLE
	stop_automated_movement = 0
	audible_emote("[emote_hear] \"Alright, I will stop\"")
	return TRUE

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
	return TRUE

////////////////////////////////
////////////BACK-END////////////
////////////////////////////////

/mob/living/simple_animal/hostile/commanded/kunit/LoseTarget()
	..()
	audible_emote("[emote_hear] \"I lost my target.\"")

/mob/living/simple_animal/hostile/commanded/kunit/OpenFire()

	// Check if we have ammo loaded, and we we do not check if have stored ammo. If no ammo at all - switch to laser rifle.
	if(gun_type == BULLET_GUN && loaded_ammo <= 0)
		if(!reload())
			audible_emote("[emote_hear] \"I am out of ammo.\"")
			switch_gun()
			ammo = FALSE
			
	if(!(target_mob in view(src)))
		audible_emote("[emote_hear] \"Can't see the target.\"")
		return
	if(rapid)
		for(var/atom/M in check_trajectory(target_mob, src, pass_flags=PASSTABLE))
			if(ismob(M))
				var/mob/L = M
				if(L == target_mob)
					break
				if((L.faction == faction) || L == master || (L == hostage && !attack_hostage))
					audible_emote("[emote_hear] \"Don't stand in my way [L].\"")
					return
			else if(istype(M, /obj/structure))
				if(istype(M, /obj/structure/window))
					audible_emote("[emote_hear] \"Laser will go through [M].\"")
					switch_gun()
					return
				else if(distance > 1)
					audible_emote("[emote_hear] \"I need to get closer to [target_mob].\"")
					walk_to(src, target_mob, distance - 1, move_to_delay) // get closer

					distance -= 1
					return
				else
					switch_mode() // We can't shoot them, but we can attack them
					return
			else if(istype(M, /obj/machinery/door/airlock/glass))
				audible_emote("[emote_hear] \"Laser will go through [M].\"")
				switch_gun()
				return
			else
				return
		var/datum/callback/shoot_cb = CALLBACK(src, .proc/shoot_wrapper, target_mob, loc, src)
		addtimer(shoot_cb, 1)
		addtimer(shoot_cb, 4)
		addtimer(shoot_cb, 6)

		loaded_ammo -= 3

	else
		for(var/atom/M in check_trajectory(target_mob, src, pass_flags=PASSTABLE|PASSGLASS|PASSGRILLE))
			if(ismob(M))
				var/mob/L = M
				if(L == target_mob)
					break
				if((L.faction == faction) || L == master || (L == hostage && !attack_hostage))
					audible_emote("[emote_hear] \"Don't stand in my way [L].\"")
					return
				else if(istype(M, /obj/structure) && !istype(M, /obj/structure/window) && distance > 1)
					audible_emote("[emote_hear] \"I need to get closer to [target_mob].\"")
					walk_to(src, target_mob, distance - 1, move_to_delay) // get closer

					distance -= 1
					return
			else
				return
		var/datum/callback/shoot_cb = CALLBACK(src, .proc/shoot_wrapper, target_mob, loc, src)
		addtimer(shoot_cb, 1)
	visible_message("<span class='warning'> <b>[src]</b> fires at [target_mob] with [weapon1]!</span>")
	stance = HOSTILE_STANCE_ATTACK
	return

/mob/living/simple_animal/hostile/commanded/kunit/AttackingTarget()
	setClickCooldown(attack_delay)
	if(!Adjacent(target_mob))
		return
	if(!see_target())
		LoseTarget()
	zone_sel.selecting = pick("chest", "head", "l_arm", "r_arm", "l_leg", "r_leg")
	if(isliving(target_mob))
		var/mob/living/L = target_mob
		L.attackby(weapon1, src)
		return L
	if(istype(target_mob, /obj/mecha))
		var/obj/mecha/M = target_mob
		M.attackby(weapon1, src)
		return M
	if(istype(target_mob, /obj/machinery/bot))
		var/obj/machinery/bot/B = target_mob
		B.attackby(weapon1, src)
		return B
	if(istype(target_mob, /obj/machinery/porta_turret))
		var/obj/machinery/porta_turret/T = target_mob
		src.do_attack_animation(T)
		T.attackby(weapon1, src)
		visible_message("<span class='danger'>[src] [attacktext] \the [T]!</span>")
		return T

/mob/living/simple_animal/hostile/commanded/kunit/proc/reload()
	if(stored_ammo <= 0)
		return FALSE
	else
		audible_emote("[emote_hear] \"Reloading\"")
		sleep(15)
		loaded_ammo = ((stored_ammo - 30) > 0) ? (30) : (stored_ammo)
		stored_ammo -= loaded_ammo
		return TRUE

#undef LASER_GUN
#undef BULLET_GUN