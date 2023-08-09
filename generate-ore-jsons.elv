#!/usr/bin/env elvish

var variants = [raw nugget ingot]

var ironOres = [
	# &iron=10
	&tin=20
	&aluminum=30
	&zinc=40
	&silver=50
	&sillicon=60
	&cobalt=70
	&lead=80
]

var ironBases = [raw_iron iron_nugget iron_ingot]

var copperOres = [
	# &copper=10
	&orichalcum=120
	&hihiirogane=130
	&meteorite=140
]

var copperBases = [raw_copper iron_nugget copper_ingot]

var goldOres = [
	# &gold=10
	&sulfur=220
	&palladium=230
	&magnesium=240
]

var goldBases = [raw_gold gold_nugget gold_ingot]

fn makeFolders { |ores|
	var keyed = [(keys $ores)]
	for key $keyed {
		mkdir -p assets/civballs/models/ores/$key
		mkdir -p assets/civballs/textures/ores/$key
		for variant $variants {
			var json = [
			    &parent=minecraft:item/generated
			    &textures=[
			        &layer0=civballs:ores/$key/$variant
			    ]
			]
			put $json | to-json | jq . > assets/civballs/models/ores/$key/$variant.json
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
		put $baseJson | to-json | jq . > assets/minecraft/models/item/$base.json
		set num = (+ $num 1)
	}

	var keyed = [(keys $ores)]
	for key $keyed {
		var value = $ores[$key]

	}
}

for kind [$ironOres $copperOres $goldOres] { makeFolders $kind }
for tuple [[$ironOres $ironBases] [$copperOres $copperBases] [$goldOres $goldBases]] { makeMinecraft $tuple[0] $tuple[1] }
