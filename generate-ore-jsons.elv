#!/usr/bin/env elvish

var variants = [dust scraps depleted raw nugget ingot]

var ironOres = [
	&iron=10
	&tin=20
	&aluminum=30
	&zinc=40
	&silver=50
	&sillicon=60
	&cobalt=70
	&lead=80
]

var ironBases = [sugar raw_iron raw_iron raw_iron iron_nugget iron_ingot]

var copperOres = [
	&copper=10
	&orichalcum=20
	&hihiirogane=30
	&meteorite=40
]

var copperBases = [gunpowder raw_copper raw_copper raw_copper iron_nugget copper_ingot]

var goldOres = [
	&gold=10
	&sulfur=20
	&palladium=30
	&magnesium=40
]

var goldBases = [glowstone_dust raw_gold raw_gold raw_gold gold_nugget gold_ingot]

fn makeFolders { |ores|
	var keyed = [(keys $ores)]
	for key $keyed {
		mkdir -p assets/civballs/models/ores/$key
		mkdir -p assets/civballs/textures/ores/$key
		for variant $variants {
			var json = [
			    &parent=minecraft:item/handheld
			    &textures=[
			        &layer0=civballs:ores/$key/$variant
			    ]
			]
			put $json | to-json > assets/civballs/models/ores/$key/$variant.json
			touch assets/civballs/textures/ores/$key/$variant.png
		}
	}
}

fn makeMinecraft { |ores bases|
	var num = 0
	for base $bases {
		var baseJson = [
			&parent=minecraft:item/generated
			&textures=[
				&layer0=minecraft:item/$base
			]
			&overrides=[(keys $ores | each { |key|
				put [&predicate=[&custom_model_data=(+ $ores[$key] $num)] &model=civballs:ores/$key/$variants[$num]]
			})]
		]
		put $baseJson | to-json > assets/minecraft/models/item/$base.json
		set num = (+ $num 1)
	}

	var keyed = [(keys $ores)]
	for key $keyed {
		var value = $ores[$key]

	}
}

for kind [$ironOres $copperOres $goldOres] { makeFolders $kind }
for tuple [[$ironOres $ironBases] [$copperOres $copperBases] [$goldOres $goldBases]] { makeMinecraft $tuple[0] $tuple[1] }
