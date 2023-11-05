#!/usr/bin/env sh

rm -f CivCiv.zip
zip -r CivCiv.zip . -x '*.git*' -x 'aseprite*' -x make.sh -x generate-ore-jsons.elv
