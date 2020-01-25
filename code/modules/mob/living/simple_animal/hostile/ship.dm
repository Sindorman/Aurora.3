/mob/living/simple_animal/hostile/ship256
    icon = 'icons/mob/spaceships/ship256.dmi'
    icon_state = "ship"
    icon_dead = "ship_destroyed"
    projectiletype = /obj/item/projectile/energy/bolt/large/ship
    projectilesound = 'sound/weapons/laser3.ogg'
    rapid = 1
    health = 500
    maxHealth = 500
    flying = TRUE
    speed = 3
    pixel_x = -128
    pixel_y = -128
    view_range = 18
    ranged = TRUE
    rapid = TRUE
    faction = "syndie"
    times_shoot = 14

/obj/item/projectile/energy/bolt/large/ship
    icon_state = "xray"
    damage = 20

/obj/item/projectile/energy/bolt/large/ship/heavy
    icon_state = "bfg"
    damage = 60

/mob/living/simple_animal/hostile/ship256/ship756
    icon = 'icons/mob/spaceships/ship756.dmi'
    projectilesound = 'sound/weapons/laserstrong.ogg'
    projectiletype = /obj/item/projectile/energy/bolt/large/ship/heavy
    health = 2500
    maxHealth = 2500
    speed = 5
    pixel_x = -378
    pixel_y = -378
    view_range = 18
    times_shoot = 7

/mob/living/simple_animal/hostile/ship256/nt
    faction = "nanotrasen"
    projectiletype = /obj/item/projectile/energy/bolt/large/ship/nt

/obj/item/projectile/energy/bolt/large/ship/nt
    icon_state = "u_laser"

/mob/living/simple_animal/hostile/ship256/ship756/nt
    faction = "nanotrasen"
    projectiletype = /obj/item/projectile/energy/bolt/large/ship/heavy/nt

/obj/item/projectile/energy/bolt/large/ship/heavy/nt
    icon_state = "bluespace"