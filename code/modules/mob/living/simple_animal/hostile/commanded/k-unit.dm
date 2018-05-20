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
	list/known_commands = list("stay", "stop", "attack", "follow")
	mob/master = null //undisputed master. Their commands hold ultimate sway and ultimate power.
	list/allowed_targets = list() //WHO CAN I KILL D:
	retribution = 1 //whether or not they will attack us if we attack them like some kinda dick.

	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 4
	stop_automated_movement_when_pulled = 0

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

	// Gun vars
	var/weapon1 = /obj/item/weapon/gun/projectile/automatic/c20r
	var/weapon2
	ranged = 1
	rapid = 1

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

/mob/living/simple_animal/hostile/commanded/Initialize()
	..()
	if(!short_name)
		short_name = name
