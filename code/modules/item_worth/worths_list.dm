//Negative values indicate that instances of these types should use the Value proc
//Mainly used so that stuff inside them can also add to their value, and other things like material,
//stuff like that.

var/list/worths = list(
//ROBOT ASSEMBLIES,
					/obj/item/secbot_assembly = 180,
					/obj/item/secbot_assembly/ed209_assembly = 280,
					/obj/item/farmbot_arm_assembly = 130,
					/obj/item/toolbox_tiles = 80,
					/obj/item/toolbox_tiles_sensor = 180,
					/obj/item/firstaid_arm_assembly = 150,
					/obj/item/bucket_sensor = 40,
//REAGENT CONTAINERS,
					/obj/item/reagent_containers/hypospray/combat = -200,
					/obj/item/reagent_containers/hypospray = -90,
					/obj/item/reagent_containers/spray = -23,
					/obj/item/reagent_containers/food/snacks/monkeycube = -35,
					/obj/item/reagent_containers/food/snacks/human = -300,
					/obj/item/reagent_containers/food/snacks/sliceable = -25,
					/obj/item/reagent_containers/food/snacks/monkeycube = -15,
					/obj/item/reagent_containers/food/snacks = -10,
					/obj/item/reagent_containers/food/drinks/bottle = -11,
					/obj/item/reagent_containers/food/drinks = -8,
					/obj/item/reagent_containers/glass/rag = -5,
					/obj/item/reagent_containers/glass = -60,
					/obj/item/reagent_containers = -1,
//ENERGY GUNS,
					/obj/item/gun/energy/rifle/pulse/destroyer = 9000,
					/obj/item/gun/energy/rifle/pulse = 7000,
					/obj/item/gun/energy/rifle/icelance = 800,
					/obj/item/gun/energy/rifle/laser/heavy = 6500,
					/obj/item/gun/energy/rifle/laser/xray = 4500,
					/obj/item/gun/energy/rifle = 1500,
					/obj/item/gun/energy/gun/nuclear = 2800,
					/obj/item/gun/energy/gun = 700,
					/obj/item/gun/energy/pistol = 550,
					/obj/item/gun/energy/laser/shotgun = 4800,
					/obj/item/gun/energy/laser/practice = 500,
					/obj/item/gun/energy/laser = 1000,
					/obj/item/gun/energy/retro = 1400,
					/obj/item/gun/energy/captain = 8500,
					/obj/item/gun/energy/xray = 3500,
					/obj/item/gun/energy/sniperrifle = 6400,
					/obj/item/gun/energy/lasertag = 10,
					/obj/item/gun/energy/pulse/pistol = 4500,
					/obj/item/gun/energy/pulse  = 5000,
					/obj/item/gun/energy/rifle/ionrifle = 2000,
					/obj/item/gun/energy/decloner = 6500,
					/obj/item/gun/energy/floragun = 1500,
					/obj/item/gun/energy/mindflayer = 4500,
					/obj/item/gun/energy/toxgun = 3500,
					/obj/item/gun/energy/beegun = 4500,
					/obj/item/gun/energy/mousegun = 2000,
					/obj/item/gun/energy/net = 3500,
					/obj/item/gun/energy/vaurca/bfg = 20000,
					/obj/item/gun/energy/vaurca/gatlinglaser = 6000,
					/obj/item/gun/energy/vaurca/blaster = 4500,
					/obj/item/gun/energy/vaurca/thermaldrill = 5000,
					/obj/item/gun/energy/vaurca = 3000,
					/obj/item/gun/energy/taser = 500,
					/obj/item/gun/energy/crossbow/largecrossbow = 1600,
					/obj/item/gun/energy/crossbow = 750,
					/obj/item/gun/energy/temperature = 3000,
					/obj/item/gun/energy/lawgiver = 7000,
					/obj/item/gun/custom_ka/frame01/prebuilt = 2500,
					/obj/item/gun/custom_ka/frame02/prebuilt = 3500,
					/obj/item/gun/custom_ka/frame03/prebuilt = 4500,
					/obj/item/gun/custom_ka/frame04/prebuilt = 5500,
					/obj/item/gun/custom_ka/frame05/prebuilt = 6500,
					/obj/item/gun/energy/plasmacutter = 6000,
					/obj/item/gun/energy/stunrevolver = 650,
					/obj/item/gun/energy/tesla = 7000,
					/obj/item/gun/energy/gravity_gun = 4500,
					/obj/item/gun/energy = 2100,
//LAUNCHERS,
					/obj/item/gun/launcher/spikethrower = 3500,
					/obj/item/gun/launcher/rocket = 8000,
					/obj/item/gun/launcher/crossbow = 120,
					/obj/item/gun/launcher/pneumatic = 200,
					/obj/item/gun/launcher/syringe = 150,
					/obj/item/gun/launcher = 300,
//AUTOMATICS,
					/obj/item/gun/projectile/automatic/rifle/sts35 = 3800,
					/obj/item/gun/projectile/automatic/rifle/z8 = 3100,
					/obj/item/gun/projectile/automatic/rifle/l6_saw = 13400,
					/obj/item/gun/projectile/automatic/rifle/shotgun = 8500,
					/obj/item/gun/projectile/automatic/rifle/w556 = 7500,
					/obj/item/gun/projectile/automatic/c20r = 3250,
					/obj/item/gun/projectile/automatic/wt550 = 2200,
					/obj/item/gun/projectile/automatic/tommygun = 4000,
					/obj/item/gun/projectile/automatic/mini_uzi = 2000,
					/obj/item/gun/projectile/automatic/railgun = 8000,
					/obj/item/gun/projectile/automatic/x9 = 2500,
					/obj/item/gun/projectile/automatic/terminator = 15000,
					/obj/item/gun/projectile/automatic = 2000,
//PROJECTILE,
					/obj/item/gun/projectile/shotgun/pump/combat = 5500,
					/obj/item/gun/projectile/shotgun/pump/rifle = 1200,
					/obj/item/gun/projectile/shotgun/pump = 3500,
					/obj/item/gun/projectile/shotgun/doublebarrel = 2500,
					/obj/item/gun/projectile/shotgun/improvised = 1000,
					/obj/item/gun/projectile/improvised_handgun = 650,
					/obj/item/gun/projectile/revolver/lemat = 1500,
					/obj/item/gun/projectile/revolver/derringer = 1700,
					/obj/item/gun/projectile/revolver/detective = 1500,
					/obj/item/gun/projectile/revolver = 3500,
					/obj/item/gun/projectile/colt = 1700,
					/obj/item/gun/projectile/sec = 1650,
					/obj/item/gun/projectile/tanto = 2500,
					/obj/item/gun/projectile/deagle = 5600,
					/obj/item/gun/projectile/gyropistol = 7500,
					/obj/item/gun/projectile/heavysniper/tranq = 6000,
					/obj/item/gun/projectile/heavysniper = 12000,
					/obj/item/gun/projectile/silenced = 1700,
					/obj/item/gun/projectile/dragunov = 2500,
					/obj/item/gun/projectile/contender = 1300,
					/obj/item/gun/projectile/leyon = 500,
					/obj/item/gun/projectile/cannon = 2100,
					/obj/item/gun/projectile/nuke = 15000,
					/obj/item/gun/projectile = 1500,
//GUN,
					/obj/item/gun/bang = 200,
					/obj/item/gun = 500,
//MATERIAL STACKS,
					/obj/item/stack/material/marble = -20,
					/obj/item/stack/material/diamond = -60,
					/obj/item/stack/material/uranium = -120,
					/obj/item/stack/material/plastic = -15,
					/obj/item/stack/material/gold = -55,
					/obj/item/stack/material/silver = -45,
					/obj/item/stack/material/platinum = -95,
					/obj/item/stack/material/mhydrogen = -110,
					/obj/item/stack/material/tritium = -100,
					/obj/item/stack/material/osmium = -100,
					/obj/item/stack/material/plasteel = -100,
					/obj/item/stack/material/phoron = -70,
					/obj/item/stack/material/wood = -2,
					/obj/item/stack/material/cloth = -3,
					/obj/item/stack/material/cardboard = -1,
					/obj/item/stack/material/glass/reinforced = -12,
					/obj/item/stack/material/glass/phoronglass = -35,
					/obj/item/stack/material/glass/phoronrglass = -65,
					/obj/item/stack/material = -5,
//STACKS,
					/obj/item/stack/medical/advanced/bruise_pack = -30,
					/obj/item/stack/medical/advanced/ointment = -40,
					/obj/item/stack/medical/splint = -25,
					/obj/item/stack/medical = -15,
					/obj/item/stack/nanopaste = -30,
					/obj/item/stack/rods = -5,
					/obj/item/stack/telecrystal = -1000,
					/obj/item/stack/wax = -5,
					/obj/item/stack = -5,
//STORAGE,
					/obj/item/storage/briefcase/crimekit = -50,
					/obj/item/storage/belt/wands = 800,
					/obj/item/storage/belt/military = 700,
					/obj/item/storage/belt/security/tactical = 500,
					/obj/item/storage/belt/soulstone = 800,
					/obj/item/storage/belt = -50,
					/obj/item/storage/backpack/holding = -3000,
					/obj/item/storage = -30,
//WEAPONS,
					/obj/item/spacecash = -1,
					/obj/item/ore = 10,
					/obj/item/mining_scanner =  130,
					/obj/item/bee_smoker = 50,
					/obj/item/anomaly_core = 20000,
					/obj/item/spellbook = 25000,
					/obj/item/am_containment = 5000,
					/obj/item/coin/diamond = 500,
					/obj/item/coin/platinum = 250,
					/obj/item/coin/phoron = 200,
					/obj/item/coin/uranium = 125,
					/obj/item/coin/gold = 50,
					/obj/item/coin/silver = 25,
					/obj/item/coin/iron = 5,
					/obj/item/coin = 3,
//MINING GEAR,
					/obj/item/pickaxe/silver = 300,
					/obj/item/pickaxe/drill = 100,
					/obj/item/pickaxe/jackhammer = 90,
					/obj/item/pickaxe/gold = 400,
					/obj/item/pickaxe/diamond = 600,
					/obj/item/pickaxe/diamonddrill = 700,
					/obj/item/pickaxe = 30,
					/obj/item/shovel/spade = 20,
					/obj/item/rfd/mining = 200,
					/obj/item/ore_radar = 30,
					/obj/item/lazarus_injector = 800,
					/obj/item/extraction_pack = 600,
					/obj/item/resonator/upgraded = 650,
					/obj/item/resonator = 450,
					/obj/item/oremagnet = 250,
					/obj/item/autochisel = 500,
					/obj/item/slimepotion = 200,
					/obj/item/slimepotion2 = 300,
					/obj/item/slimesteroid = 150,
					/obj/item/slimesteroid2 = 250,
					/obj/item/portable_destructive_analyzer = 780,
					/obj/item/inflatable_dispenser = 300,
					/obj/item/matter_decompiler = 400,
//COMPUTER HARDWARE,
					/obj/item/computer_hardware/battery_module/advanced = 110,
					/obj/item/computer_hardware/battery_module/super = 150,
					/obj/item/computer_hardware/battery_module/ultra = 190,
					/obj/item/computer_hardware/battery_module/micro = 80,
					/obj/item/computer_hardware/battery_module/nano = 60,
					/obj/item/computer_hardware/battery_module/lambda = 100000,
					/obj/item/computer_hardware/hard_drive/advanced = 160,
					/obj/item/computer_hardware/hard_drive/super = 250,
					/obj/item/computer_hardware/hard_drive/cluster = 500,
					/obj/item/computer_hardware/hard_drive/small = 100,
					/obj/item/computer_hardware/hard_drive/micro = 60,
					/obj/item/computer_hardware/hard_drive/portable = 30,
					/obj/item/computer_hardware/hard_drive/portable/advanced = 60,
					/obj/item/computer_hardware/hard_drive/portable/super = 125,
					/obj/item/computer_hardware/network_card/advanced = 90,
					/obj/item/computer_hardware/network_card/wired = 40,
					/obj/item/computer_hardware/processor_unit/small = 80,
					/obj/item/computer_hardware/processor_unit/photonic = 400,
					/obj/item/computer_hardware/processor_unit/photonic/small = 120,
					/obj/item/computer_hardware/processor_unit = 200,
					/obj/item/computer_hardware/tesla_link = 350,
					/obj/item/computer_hardware = 80,
					/obj/item/computer_hardware/hard_drive = 125,
					/obj/item/clipboard = 15,
//POWER CELLS,
					/obj/item/cell/device = 100,
					/obj/item/cell/crap = 30,
					/obj/item/cell/apc = 130,
					/obj/item/cell/high = 160,
					/obj/item/cell/mecha = 220,
					/obj/item/cell/super = 280,
					/obj/item/cell/hyper = 310,
					/obj/item/cell/infinite = 50000,
					/obj/item/cell/potato = 1,
					/obj/item/cell/slime = 160,
					/obj/item/cell = 60,
//SMES COILS,
					/obj/item/smes_coil/weak = 1000,
					/obj/item/smes_coil/super_capacity = 5000,
					/obj/item/smes_coil/super_io = 4500,
					/obj/item/smes_coil = 2000,
					/obj/item/tracker_electronics = 150,
					/obj/item/am_containment = 5000,
					/obj/item/syringe_cartridge = 20,
					/obj/item/silencer = 60,
					/obj/item/fossil = 100,
					/obj/item/vampiric = 666,
					/obj/item/anobattery = 1800,
					/obj/item/anodevice = 3300,
					/obj/item/scrying = 20000,
					/obj/item/soap/deluxe = 15,
					/obj/item/cane/concealed = 250,
					/obj/item/cane = 40,
					/obj/item/disk/nuclear = 10000,
					/obj/item/disk = 90,
					/obj/item/clothing/suit/caution = 15,
					/obj/item/module = 100,
//STOCK PARTS,
					/obj/item/stock_parts/capacitor/adv = 160,
					/obj/item/stock_parts/scanning_module/adv = 160,
					/obj/item/stock_parts/manipulator/nano = 160,
					/obj/item/stock_parts/micro_laser/high = 160,
					/obj/item/stock_parts/matter_bin/adv = 160,
					/obj/item/stock_parts/capacitor/super = 300,
					/obj/item/stock_parts/scanning_module/phasic = 300,
					/obj/item/stock_parts/manipulator/pico = 250,
					/obj/item/stock_parts/micro_laser/ultra = 290,
					/obj/item/stock_parts/matter_bin/super = 310,
					/obj/item/stock_parts/subspace/ansible = 500,
					/obj/item/stock_parts/subspace/filter = 560,
					/obj/item/stock_parts/subspace/amplifier = 540,
					/obj/item/stock_parts/subspace/treatment = 570,
					/obj/item/stock_parts/subspace/analyzer = 630,
					/obj/item/stock_parts/subspace/crystal = 530,
					/obj/item/stock_parts/subspace/transmitter = 620,
					/obj/item/stock_parts = 80,
					/obj/item/ectoplasm = 700,
					/obj/item/toy/xmas_cracker = 20,
					/obj/item/pinpointer/advpinpointer = 330,
					/obj/item/pinpointer = 180,
					/obj/item/airalarm_electronics = 90,
					/obj/item/firealarm_electronics = 80,
					/obj/item/camera_assembly = 35,
					/obj/item/orion_ship = 100,
					/obj/item/airlock_electronics/secure = 600,
					/obj/item/airlock_electronics = 300,
					/obj/item/cartridge = 50,
					/obj/item/aiModule = 3000,
					/obj/item/autopsy_scanner = 180,
//CARDS,
					/obj/item/card/data/clown = 6000,
					/obj/item/card/data = 300,
					/obj/item/card/emag = 600,
					/obj/item/card/id/silver = 200,
					/obj/item/card/id/gold = 5000,
					/obj/item/card/id/captains_spare = 5000,
					/obj/item/card/id/syndicate_command = 7000,
					/obj/item/card/id/centcom = 7000,
					/obj/item/card/id/all_access = 10000,
					/obj/item/card/id = 30,
					/obj/item/flame/match = 1,
					/obj/item/flame/lighter/zippo = 10,
					/obj/item/plastique = 200,
					/obj/item/extinguisher/mini = 20,
					/obj/item/extinguisher = 40,
					/obj/item/flamethrower = 60,
					/obj/item/handcuffs/cable = 5,
					/obj/item/handcuffs = 35,
					/obj/item/rfd/construction = 1000,
					/obj/item/rfd_ammo = 50,
					/obj/item/rfd/service = 300,
					/obj/item/teleportation_scroll = 7000,
					/obj/item/shield/riot/tact = 500,
					/obj/item/shield/riot = 150,
					/obj/item/shield/buckler = 200,
					/obj/item/shield/energy = 1200,
//SURGERY,
					/obj/item/surgery/retractor = 80,
					/obj/item/surgery/hemostat = 90,
					/obj/item/surgery/cautery = 110,
					/obj/item/surgery/surgicaldrill = 130,
					/obj/item/surgery/scalpel/laser1 = 300,
					/obj/item/surgery/scalpel/laser2 = 600,
					/obj/item/surgery/scalpel/laser3 = 900,
					/obj/item/surgery/scalpel/manager = 1200,
					/obj/item/surgery/scalpel = 60,
					/obj/item/surgery/circular_saw = 140,
					/obj/item/surgery/bonegel = 300,
					/obj/item/surgery/FixOVein = 500,
					/obj/item/surgery/bonesetter = 150,
					/obj/item/locator = 100,
					/obj/item/wrench = 30,
					/obj/item/screwdriver = 15,
					/obj/item/wirecutters = 25,
//WELDINGTOOLS,
					/obj/item/weldingtool/largetank = 150,
					/obj/item/weldingtool/hugetank = 300,
					/obj/item/weldingtool/experimental = 600,
					/obj/item/weldingtool = 100,
					/obj/item/crowbar = 10,
					/obj/item/trap = 35,
					/obj/item/nullrod = 60,
					/obj/item/weldpack = 300,
					/obj/item/circuitboard/aicore = 6000,
					/obj/item/circuitboard = 1000,
//GRENADES,
					/obj/item/grenade/anti_photon = 200,
					/obj/item/grenade/empgrenade = 180,
					/obj/item/grenade/frag = 300,
					/obj/item/grenade/spawnergrenade/vaurca = 700,
					/obj/item/grenade/spawnergrenade/manhacks = 600,
					/obj/item/grenade/spawnergrenade/spesscarp = 350,
					/obj/item/grenade/spawnergrenade = 300,
					/obj/item/grenade = 150,
					/obj/item/implant = 100,
					/obj/item/implanter = 80,
//MELEE,
					/obj/item/melee/cultblade = 1500,
					/obj/item/melee/energy/wizard = 15000,
					/obj/item/melee/energy/glaive = 5400,
					/obj/item/melee/energy/sword/powersword = 8000,
					/obj/item/melee/energy/sword = 5000,
					/obj/item/melee/energy/axe = 9000,
					/obj/item/melee/energy = 4200,
					/obj/item/melee/chainofcommand = 200,
					/obj/item/melee/baton/stunrod = 350,
					/obj/item/melee/baton/cattleprod = 30,
					/obj/item/melee/baton = 80,
					/obj/item/melee/classic_baton = 30,
					/obj/item/melee/telebaton = 450,
					/obj/item/melee/chainsword = 3000,
					/obj/item/melee/ceremonial_sword = 2500,
					/obj/item/melee/hammer = 1200,
					/obj/item/melee/whip = 400,
					/obj/item/melee/vaurca/navcomp = 1500,
					/obj/item/melee/vaurca/rock = 700,
					/obj/item/tank/jetpack = 390,
					/obj/item/tank = 40,
					/obj/item/contract = 20000,
					/obj/item/ladder_mobile = 250,
					/obj/item/contraband/poster = 25,
//MATERIAL,
					/obj/item/material/twohanded/pike/halberd = -120,
					/obj/item/material/twohanded/pike = -100,
					/obj/item/material/twohanded/zweihander = -350,
					/obj/item/material/twohanded/fireaxe = -150,
					/obj/item/material/knife/bayonet = -100,
					/obj/item/material/sword = -120,
					/obj/item/material/scythe = -100,
					/obj/item/material/harpoon = -70,
					/obj/item/material = -5,
//RIGS,
					/obj/item/rig/unathi/fancy = 30000,
					/obj/item/rig/unathi = 17000,
					/obj/item/rig/combat = 25000,
					/obj/item/rig/ert = 20000,
					/obj/item/rig/light/hacker = 13000,
					/obj/item/rig/light/ninja = 16000,
					/obj/item/rig/light/stealth = 11000,
					/obj/item/rig/light = 14000,
					/obj/item/rig/internalaffairs = 9000,
					/obj/item/rig/merc = 25000,
					/obj/item/rig/military = 30000,
					/obj/item/rig/terminator = 30000,
					/obj/item/rig = 15000,
					/obj/item/forensics = 65,
					/obj/item/evidencebag = 5,
					/obj/item/sample = 15,
					/obj/item/board = 15,
					/obj/item/storage/card = 10,
					/obj/item/pack = 6,
					/obj/item/holo = 0,
					/obj/item/beach_ball/holoball = 0,
					/obj/item/book/tome = 350,
					/obj/item/book = 15,
					/obj/item/barcodescanner = 130,
//CLOTHING,
//EARS,
					/obj/item/clothing/ears/skrell = 100,
					/obj/item/clothing/ears/bandanna = 20,
//GLASSES,
					/obj/item/clothing/glasses/meson/prescription = 880,
					/obj/item/clothing/glasses/meson = 800,
					/obj/item/clothing/glasses/science = 400,
					/obj/item/clothing/glasses/night = 1000,
					/obj/item/clothing/glasses/regular/hipster = 400, //Hipstering is an expensive lifestyle yo,
					/obj/item/clothing/glasses/regular = 300,
					/obj/item/clothing/glasses/welding/superior = 450,
					/obj/item/clothing/glasses/welding = 250,
					/obj/item/clothing/glasses/sunglasses/prescription = 230,
					/obj/item/clothing/glasses/sunglasses/sechud/tactical = 550,
					/obj/item/clothing/glasses/sunglasses/sechud = 530,
					/obj/item/clothing/glasses/thermal = 1990,
					/obj/item/clothing/glasses/night = 1200,
					/obj/item/clothing/glasses = 150,
//GLOVES,
					/obj/item/clothing/gloves/boxing = 60,
					/obj/item/clothing/gloves/yellow = 300,
					/obj/item/clothing/gloves/fyellow = 25, //cheap cheap cheap,
					/obj/item/clothing/gloves/captain = 100,
					/obj/item/clothing/gloves/swat = 125,
					/obj/item/clothing/gloves/combat = 400,
					/obj/item/clothing/gloves/botanic_leather = 6,
					/obj/item/clothing/gloves/force/syndicate = 1500,
					/obj/item/clothing/gloves/force = 1000,
					/obj/item/clothing/gloves = 5,

//MASKS,
					/obj/item/clothing/mask/luchador = 60,
					/obj/item/clothing/mask/breath/medical = 180,
					/obj/item/clothing/mask/breath = 80,
					/obj/item/clothing/mask/gas/plaguedoctor = 100,
					/obj/item/clothing/mask/gas/swat = 200,
					/obj/item/clothing/mask/gas/voice = 600,
					/obj/item/clothing/mask/gas/tactical = 500,
					/obj/item/clothing/mask/gas = 50,
					/obj/item/clothing/mask/muzzle/tape = 2,
					/obj/item/clothing/mask/muzzle = 100,
					/obj/item/clothing/mask/surgical = 20,
					/obj/item/clothing/mask/fakemoustache = 5,
					/obj/item/clothing/mask/snorkel = 5,
					/obj/item/clothing/mask/ai = 3000,
//SHOES,
					/obj/item/clothing/shoes/galoshes = 50,
					/obj/item/clothing/shoes/syndigaloshes = 250,
					/obj/item/clothing/shoes/clown_shoes = 100,
					/obj/item/clothing/shoes/cult = 350,
					/obj/item/clothing/shoes/magboots = 350,
					/obj/item/clothing/shoes/swat = 200,
					/obj/item/clothing/shoes/combat = 450,
					/obj/item/clothing/shoes = 25,
//SUITS,
					/obj/item/clothing/suit/space/void/wizard = 5000,
					/obj/item/clothing/suit/space/void/captain = 4000,
					/obj/item/clothing/suit/space/void/merc = 3000,
					/obj/item/clothing/suit/space/void/security = 3000,
					/obj/item/clothing/suit/space/void = 2800,
					/obj/item/clothing/suit/space/syndicate = 2200,
					/obj/item/clothing/suit/space/void/skrell = 3000,
					/obj/item/clothing/suit/space/cult = 1050,
					/obj/item/clothing/suit/space/emergency = 150,
					/obj/item/clothing/suit/space = 730,
					/obj/item/clothing/suit/unathi/mantle = 80,
					/obj/item/clothing/suit/cultrobes = 200,
					/obj/item/clothing/suit/storage/vest/heavy/ert = 2500,
					/obj/item/clothing/suit/storage/vest/merc = 3000,
					/obj/item/clothing/suit/armor/vest/ert = 2500,
					/obj/item/clothing/suit/armor/vest = 550,
					/obj/item/clothing/suit/armor/riot = 700,
					/obj/item/clothing/suit/armor/bulletproof = 700,
					/obj/item/clothing/suit/armor/laserproof = 700,
					/obj/item/clothing/suit/armor/reactive = 5000,
					/obj/item/clothing/suit/armor/centcomm = 2000,
					/obj/item/clothing/suit/armor/heavy = 1000,
					/obj/item/clothing/suit/armor/hos = 1000,
					/obj/item/clothing/suit/armor/tactical = 1500,
					/obj/item/clothing/suit/armor = 500,
					/obj/item/clothing/suit/bio_suit = 150,
					/obj/item/clothing/suit/captunic/capjacket = 100,
					/obj/item/clothing/suit/security/navyhos = 80,
					/obj/item/clothing/suit/storage/hazardvest = 60,
					/obj/item/clothing/suit/storage/toggle/labcoat = 55,
					/obj/item/clothing/suit/bluetag = 20,
					/obj/item/clothing/suit/redtag = 20,
					/obj/item/clothing/suit/fire/heavy = 600,
					/obj/item/clothing/suit/fire = 500,
					/obj/item/clothing/suit/radiation = 450,
					/obj/item/clothing/suit/bomb_suit = 300,
//HEADS,
					/obj/item/clothing/head/collectable/petehat = 350,
					/obj/item/clothing/head/collectable = 80,
					/obj/item/clothing/head/hardhat = 180,
					/obj/item/clothing/head/helmet/swat = 400,
					/obj/item/clothing/head/helmet/gladiator = 280,
					/obj/item/clothing/head/helmet/augment = 600,
					/obj/item/clothing/head/helmet/riot = 500,
					/obj/item/clothing/head/helmet/ablative = 500,
					/obj/item/clothing/head/helmet/ballistic = 500,
					/obj/item/clothing/head/helmet/merc = 1000,
					/obj/item/clothing/head/helmet/tactical = 800,
					/obj/item/clothing/head/helmet/gladiator = 300,
					/obj/item/clothing/head/helmet/ert = 1000,
					/obj/item/clothing/head/helmet/hos = 800,
					/obj/item/clothing/head/hos/cap = 100,
					/obj/item/clothing/head/hos/cap/alt = 100,
					/obj/item/clothing/head/helmet = 250,
					/obj/item/clothing/head/culthood = 150,
					/obj/item/clothing/head/caphat/hop = 100,
					/obj/item/clothing/head/caphat = 200,
					/obj/item/clothing/head/centhat = 600,
					/obj/item/clothing/head/pin/flower = 5,
					/obj/item/clothing/head/powdered_wig = 80,
					/obj/item/clothing/head/justice = 30,
					/obj/item/clothing/head/philosopher_wig = 70,
					/obj/item/clothing/head/welding = 150,
					/obj/item/clothing/head/bomb_hood = 200,
					/obj/item/clothing/head/radiation = 250,
					/obj/item/clothing/head/bio_hood = 100,
					/obj/item/clothing/head/navy = 250,
					/obj/item/clothing/head/dress/admiral = 1000,
					/obj/item/clothing/head/dress = 350,
					/obj/item/clothing/head/helmet/space/void/wizard = 4000,
					/obj/item/clothing/head/helmet/space/void/merc = 2000,
					/obj/item/clothing/head/helmet/space/void/security = 2000,
					/obj/item/clothing/head/helmet/space/void/captain = 3000,
					/obj/item/clothing/head/helmet/space/void = 1900,
					/obj/item/clothing/head/helmet/space/syndicate = 1200,
					/obj/item/clothing/head/helmet/space/deathsquad = 2400,
					/obj/item/clothing/head/helmet/space/void/skrell = 1200,
					/obj/item/clothing/head/helmet/space/cult = 1300,
					/obj/item/clothing/head/helmet/space/emergency = 250,
					/obj/item/clothing/head/helmet/space = 450,
//ACCESSORIES,
					/obj/item/clothing/accessory/storage/bayonet = 250,
					/obj/item/clothing/accessory/storage = 55,
					/obj/item/clothing/accessory/stethoscope = 70,
					/obj/item/clothing/accessory/medal/gold/captain = 800,
					/obj/item/clothing/accessory/medal/gold = 600,
					/obj/item/clothing/accessory/medal/silver = 300,
					/obj/item/clothing/accessory/medal/iron = 150,
					/obj/item/clothing/accessory/medal = 100,
					/obj/item/clothing/accessory/armband = 30,
					/obj/item/clothing/accessory/badge = 60,
					/obj/item/clothing/accessory = 15,
//UNDERS,
					/obj/item/clothing/under/rank/captain = 100,
					/obj/item/clothing/under/rank/head_of_personnel = 60,
					/obj/item/clothing/under/rank/head_of_personnel_whimsy = 80,
					/obj/item/clothing/under/rank/chief_engineer = 95,
					/obj/item/clothing/under/rank/research_director = 60,
					/obj/item/clothing/under/rank/chief_medical_officer = 65,
					/obj/item/clothing/under/rank/warden = 5,
					/obj/item/clothing/under/rank/centcom = 200,
					/obj/item/clothing/under/rank/fatigues = 250,
					/obj/item/clothing/under/rank/service = 350,
					/obj/item/clothing/under/rank/dress/admiral = 1000,
					/obj/item/clothing/under/rank/dress = 450,
					/obj/item/clothing/under/rank/centcom_commander = 300,
					/obj/item/clothing/under/syndicate/tacticool = 60,
					/obj/item/clothing/under/syndicate = 150,
					/obj/item/clothing/under/tactical = 150,
					/obj/item/clothing/under/ert = 200,
					/obj/item/clothing/under/ccpolice = 250,
					/obj/item/clothing/under/space = 400,
					/obj/item/clothing = 50,
//DEVICES,
					/obj/item/device/magnetic_lock = 700,
					/obj/item/device/wormhole_jaunter = 500,
					/obj/item/device/soulstone = 10000,
					/obj/item/device/dociler = 450,
					/obj/item/device/mmi = 1200,
					/obj/item/device/kit = 100,
					/obj/item/aicard = 6000,
					/obj/item/device/chameleon = 4000,
					/obj/item/device/paicard = 120,
					/obj/item/device/powersink = 1800,
					/obj/item/hand_tele = 1800,
					/obj/item/device/mass_spectrometer/adv = 400,
					/obj/item/device/mass_spectrometer = 300,
					/obj/item/device/reagent_scanner/adv = 600,
					/obj/item/device/reagent_scanner = 500,
					/obj/item/device/slime_scanner = 300,
					/obj/item/device/transfer_valve = 50,
					/obj/item/device/violin = 250,
					/obj/item/device/pda = 60,
					/obj/item/device/radio = 150,
					/obj/item/device/assembly/igniter = 15,
					/obj/item/device/assembly/infra = 10,
					/obj/item/device/assembly/mousetrap = 5,
					/obj/item/device/assembly/signaler = 30,
					/obj/item/device/assembly = 50,
					/obj/item/device/uv_light = 150,
					/obj/item/device/eftpos = 30,
					/obj/item/device = 90,
//ORGANS,
					/obj/item/organ/internal/heart = 1200,
					/obj/item/organ/internal/brain/golem = 3000,
					/obj/item/organ/internal/brain = 1200,
					/obj/item/organ/vaurca/neuralsocket = 1500,
					/obj/item/organ = 400,
//ITEMS,
					/obj/item/slime_extract = 200,
					/obj/item/robot_parts/robot_component = 250,
					/obj/item/robot_parts = 30,
					/obj/item/modular_computer/tablet = 1300,
					/obj/item/modular_computer = 4000,
					/obj/item/solar_assembly = 680,
					/obj/item/ammo_casing/cannon = 200,
					/obj/item/ammo_casing = 5,
					/obj/item/ammo_magazine/nuke = 1200,
					/obj/item/ammo_magazine = 30,
					/obj/item/conveyor_construct = 100,
					/obj/item/conveyor_switch_construct = 30,
					/obj/item/supply_beacon = 5000,
					/obj/item/frame = 60,
					/obj/item/pipe = 100,
					/obj/item/pipe_meter = 300,
					/obj/item/mecha_equipment/catapult = 3000,
					/obj/item/mecha_equipment/mounted_system/taser/laser = 2000,
					/obj/item/mecha_equipment/mounted_system/taser/ion = 1550,
					/obj/item/mecha_equipment/mounted_system/taser = 1000,
					/obj/item/mecha_equipment/mounted_system/taser/smg = 5800,
					/obj/item/mecha_equipment = 1000,
					/obj/item/missile = 1200,
					/obj/item/blueprints = 4000, //Information is valuable,
					/obj/item/bodybag/cryobag = 600,
					/obj/item/bodybag = 20,
					/obj/item/glass_jar = 10,
					/obj/item/target = 15,
					/obj/item/inflatable = 30,
					/obj/item/roller = 80,
					/obj/item/light/tube/colored = 20,
					/obj/item/light/bulb/colored = 15,
					/obj/item/rig_module/grenade_launcher = 1500,
					/obj/item/rig_module/mounted/energy_blade = 5000,
					/obj/item/rig_module/mounted/thermalldrill = 2500,
					/obj/item/rig_module/mounted/plasmacutter = 2500,
					/obj/item/rig_module/mounted/ion = 2000,
					/obj/item/rig_module/mounted/xray = 3500,
					/obj/item/rig_module/mounted/smg = 2500,
					/obj/item/rig_module/mounted/pulse = 4500,
					/obj/item/rig_module/mounted/taser = 1500,
					/obj/item/rig_module/mounted/egun = 2100,
					/obj/item/rig_module/mounted/energy_blade = 5500,
					/obj/item/rig_module/mounted = 4100,
					/obj/item/rig_module/stealth_field = 2500,
					/obj/item/rig_module/teleporter = 3000,
					/obj/item/rig_module/fabricator/energy_net = 1200,
					/obj/item/rig_module/fabricator = 2800,
					/obj/item/rig_module = 1000,
					/obj/item/seeds = 10,
					/obj/item/honey_frame = 15,
					/obj/item/beehive_assembly = 100,
					/obj/item/bee_pack = 200,
					/obj/item/weedkiller = 30,
					/obj/item/phylactery = 40000,
					/obj/item/bluespace_crystal/artificial = 5000,
					/obj/item/bluespace_crystal = 10000,
					/obj/item/vaurca/box = 250,
					/obj/item/hoist_kit = 150,
					/obj/item = 5,
//STRUCTURES,
					/obj/structure/ore_box = 12,
					/obj/structure/constructshell = 5000,
					/obj/structure/cable = 1,
					/obj/structure/particle_accelerator = 2000,
					/obj/structure/droppod_door = 65,
					/obj/structure/disposalconstruct = 0, //Similar to cables, they are assembled into something else,
					/obj/structure/disposalpipe/tagger = 70,
					/obj/structure/disposalpipe/sortjunction = 65,
					/obj/structure/disposalpipe = 35,
					/obj/structure/disposaloutlet = 65,
					/obj/structure/boulder = 0, //just a dumb boulder,
					/obj/structure/shuttle = 150,
					/obj/structure/plasticflaps = 15,
					/obj/structure/cult/pylon = 700,
					/obj/structure/cult = 160,
					/obj/structure/cryofeed = 450,
					/obj/structure/AIcore = 6000,
					/obj/structure/AIcore/deactivated = 7000,
					/obj/structure/computerframe = 50,
					/obj/item/toy/plushie/ = 7,
					/obj/structure/bedsheetbin = 25,
					/obj/structure/coatrack = 10,
					/obj/structure/displaycase = 86,
					/obj/structure/door_assembly = 35,
					/obj/structure/girder = 15,
					/obj/structure/grille = 5,
					/obj/structure/inflatable = 1,
					/obj/structure/janitorialcart = 120,
					/obj/structure/kitchenspike = 35,
					/obj/structure/lattice = 1,
					/obj/structure/morgue = 100,
					/obj/structure/crematorium = 600,
					/obj/structure/device/piano = 1200, //pianos are expensive,
					/obj/structure/noticeboard = 15,
					/obj/structure/safe/floor = 180,
					/obj/structure/safe = 200,
					/obj/structure/sign = 25,
					/obj/structure/dispenser = 500,
					/obj/structure/transit_tube = 80,
					/obj/structure/transit_tube_pod = 100,
					/obj/structure/toilet = 50,
					/obj/structure/alien = 300,
					/obj/structure/closet = 15,
					/obj/structure/bed = 7,
					/obj/structure/holostool = 0,
					/obj/structure/holohoop = 0,
					/obj/structure/bookcase = 50,
					/obj/structure/barricade = -1,
					/obj/structure = 30,
//BOTS,
					/mob/living/bot/cleanbot = 260,
					/mob/living/bot/farmbot = 500,
					/mob/living/bot/floorbot = 190,
					/mob/living/bot/medbot = 600,
					/mob/living/bot/secbot/ed209 = 1200,
					/mob/living/bot/secbot = 800,
					/mob/living/bot = 300,
//MOBS,
					/mob/living/carbon/human = -10000,
					/mob/living/carbon/slime = 5000,
					/mob/living/silicon/robot = 10000,
					/mob/living/silicon/pai = 1000,
					/mob/living/silicon/ai = 50000,
					/mob/living/silicon = 5000,
					/mob/living/simple_animal/hostile/commanded/dog = 1000,
					/mob/living/simple_animal/hostile/true_changeling = 20000,
					/mob/living/simple_animal/hostile/biglizard = 10000,
					/mob/living/simple_animal/hostile/bear/spatial = 2000,
					/mob/living/simple_animal/hostile = 700,
					/mob/living/simple_animal/construct = 10000,
					/mob/living/simple_animal/rat/king = 5000,
					/mob/living/simple_animal/rat = 10,
					/mob/living/simple_animal/borer = 10000,
					/mob/living/simple_animal/corgi/Ian = 1000, //Ian is valuable,
					/mob/living/simple_animal/spiderbot = 3000,
					/mob/living/simple_animal/cow = 2000, //Cow expensive,
					/mob/living/simple_animal = 500,
					/mob/living = 100,
//MECHAS,
					/mob/living/heavy_vehicle/premade/combat = -50000,
					/mob/living/heavy_vehicle/premade/heavy = -40000,
					/mob/living/heavy_vehicle/premade/ripley = -20000,
					/mob/living/heavy_vehicle/premade/light = -20000,
//MACHINERY,
					/obj/machinery/from_beyond = -30000,
					/obj/machinery/mineral/unloading_machine = -500,
					/obj/machinery/mining/brace = -300,
					/obj/machinery/drone_fabricator = -3000,
					/obj/machinery/photocopier/faxmachine = -500,
					/obj/machinery/papershredder = -80,
					/obj/machinery/gravity_generator = -16000,
					/obj/machinery/light = 25,
					/obj/machinery/power/smes/buildable = -15000,
					/obj/machinery/compressor = -4000,
					/obj/machinery/power/turbine = -6000,
					/obj/machinery/computer/turbine_computer = -2000,
					/obj/machinery/chem_master = -6000,
					/obj/machinery/chemical_dispenser = -5000,
					/obj/machinery/conveyor = 200,
					/obj/machinery/conveyor_switch = 100,
					/obj/machinery/disposal = 500,
					/obj/machinery/blackbox_recorder = -9500,
					/obj/machinery/r_n_d/protolathe = -15000,
					/obj/machinery/r_n_d/server = -20000,
					/obj/machinery/r_n_d = -1000,
					/obj/machinery/auto_cloner = -13000,
					/obj/machinery/giga_drill = -1900,
					/obj/machinery/artifact = -13500,
					/obj/machinery/artifact_analyser = -11900,
					/obj/machinery/artifact_harvester = -12300,
					/obj/machinery/artifact_scanpad = -1800,
					/obj/machinery/suspension_gen = -3000,
					/obj/machinery/keycard_auth = -100,
					/obj/machinery/power/supermatter/shard = 100000,
					/obj/machinery/power/supermatter = 500000,
					/obj/machinery/atmospherics/pipe/simple/heat_exchanging = -1000,
					/obj/machinery/atmospherics/pipe = -100,
					/obj/machinery/atmospherics/portables_connector = -500,
					/obj/machinery/atmospherics/tvalve = -150,
					/obj/machinery/atmospherics/valve = -120,
					/obj/machinery/atmospherics/binary/circulator = -2500,
					/obj/machinery/atmospherics/binary/dp_vent_pump = -850,
					/obj/machinery/atmospherics/binary/passive_gate = -1600,
					/obj/machinery/atmospherics/pipeturbine = -3000,
					/obj/machinery/atmospherics/binary/pump = -1900,
					/obj/machinery/atmospherics/binary/pump/high_power = -2500,
					/obj/machinery/atmospherics/omni/filter = -4000,
					/obj/machinery/atmospherics/omni/mixer = -3600,
					/obj/machinery/atmospherics/trinary/filter = -3300,
					/obj/machinery/atmospherics/trinary/mixer = -3000,
					/obj/machinery/atmospherics/unary/freezer = -6000,
					/obj/machinery/atmospherics/unary/generator_input = -2500,
					/obj/machinery/atmospherics/unary/heater = -6000,
					/obj/machinery/atmospherics/unary/outlet_injector = -2300,
					/obj/machinery/atmospherics/unary/oxygen_generator = -10000,
					/obj/machinery/atmospherics/unary/vent_pump = -2000,
					/obj/machinery/atmospherics/unary/vent_scrubber = -2300,
					/obj/machinery/bodyscanner = -6000,
					/obj/machinery/body_scanconsole = -1500,
					/obj/machinery/ai_slipper = -500,
					/obj/machinery/alarm = -800,
					/obj/machinery/air_sensor = -800,
					/obj/machinery/autolathe = -3300,
					/obj/machinery/bluespacerelay = -4000,
					/obj/machinery/button = 100,
					/obj/machinery/cablelayer = -1700,
					/obj/machinery/cell_charger = -90,
					/obj/machinery/constructable_frame = -500,
					/obj/machinery/cryopod = -3000,
					/obj/machinery/deployable/barrier = -500,
					/obj/machinery/floodlight = -200,
					/obj/machinery/floor_light = -100,
					/obj/machinery/floorlayer = -1500,
					/obj/machinery/igniter = -300,
					/obj/machinery/sparker = -500,
					/obj/machinery/iv_drip = -100,
					/obj/machinery/media/jukebox = -700,
					/obj/machinery/magnetic_module = -500,
					/obj/machinery/magnetic_controller = -500,
					/obj/machinery/mass_driver = -500,
					/obj/machinery/navbeacon = -90,
					/obj/machinery/newscaster = -100,
					/obj/machinery/nuclearbomb = -10000,
					/obj/machinery/recharger = -200,
					/obj/machinery/sleeper = -4000,
					/obj/machinery/space_heater = -500,
					/obj/machinery/ai_status_display = -600,
					/obj/machinery/teleport = -15000,
					/obj/machinery/camera = -700,
					/obj/machinery/airlock_sensor = -800,
					/obj/machinery/door/airlock = -800,
					/obj/machinery/door/blast/shutters = -300,
					/obj/machinery/door/blast = -1000,
					/obj/machinery/door/firedoor = -600,
					/obj/machinery/door = -100,
					/obj/machinery/door_timer = -300,
					/obj/machinery/embedded_controller/radio/airlock = -600,
					/obj/machinery/gibber = -600,
					/obj/machinery/pipedispenser = -100,
					/obj/machinery/telecomms/broadcaster = -10000,
					/obj/machinery/telecomms = -7000,
					/obj/machinery/shower = -300,
					/obj/machinery/acting/changer = -3000,
					/obj/machinery/computer/artillerycontrol = -1400,
					/obj/machinery/dnaforensics = -1200,
					/obj/machinery/microscope = -550,
					/obj/machinery/atm = -4500,
					/obj/machinery/readybutton = -0,
					/obj/machinery/botany/editor = -16000,
					/obj/machinery/botany = -9050,
					/obj/machinery/seed_storage = -500,
					/obj/machinery/beehive = -500,
					/obj/machinery/portable_atmospherics/hydroponics/soil = 1, //its dirt,
					/obj/machinery/portable_atmospherics/hydroponics = -2300,
					/obj/machinery/librarypubliccomp = -600,
					/obj/machinery/librarycomp = -1000,
					/obj/machinery/libraryscanner = -1000,
					/obj/machinery/bookbinder = -1200,
					/obj/machinery/wish_granter = - 1000000,
					/obj/machinery = -1000,
					/obj/vehicle/bike = 1500,
					/obj/vehicle = 1000
					) //Must be in descending order. Child before parents, otherwise it doesn't work.,

