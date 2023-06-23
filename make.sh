#!/usr/bin/env sh

rm -f CivCiv.zip
zip -r CivCiv.zip . -x '*.git*' -x make.sh -x generate-ore-jsons.elv
