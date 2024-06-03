#!/usr/bin/env elvish

# SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
#
# SPDX-License-Identifier: MIT

var variants = [raw nugget ingot]

var ironOres = [
	&adamantite=10
	&arilla=20
	&mythril=30
	&orichalcum=40
	&palladium=50
]

var ironBases = [raw_iron iron_nugget iron_ingot]

fn makeFolders { |ores|
	var keyed = [(keys $ores)]
	for key $keyed {
		mkdir -p assets/civcubed/models/ores/$key
		mkdir -p assets/civcubed/textures/ores/$key
		for variant $variants {
			var json = [
			    &parent=minecraft:item/generated
			    &textures=[
			        &layer0=civcubed:ores/$key/$variant
			    ]
			]
			put $json | to-json | jq . > assets/civcubed/models/ores/$key/$variant.json
			touch assets/civcubed/textures/ores/$key/$variant.png
		}
	}
}

fn makeMinecraft { |ores bases|
	var num = 0
	for base $bases {
		if (eq $base _) {
		    set num = (+ $num 1)
			continue
		}
		var baseJson = [
			&parent=minecraft:item/generated
			&textures=[
				&layer0=minecraft:item/$base
			]
			&overrides=[(keys $ores | order &less-than={ |a b|
				< (+ $ores[$a] $num) (+ $ores[$b] $num)
			} | each { |key|
				put [&predicate=[&custom_model_data=(+ $ores[$key] $num)] &model=civcubed:ores/$key/$variants[$num]]
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

for kind [$ironOres] { makeFolders $kind }
for tuple [[$ironOres $ironBases]] { makeMinecraft $tuple[0] $tuple[1] }
