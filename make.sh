#!/usr/bin/env sh

# SPDX-FileCopyrightText: 2023 Janet Blackquill <uhhadd@gmail.com>
#
# SPDX-License-Identifier: MIT

rm -f CivCiv.zip
zip -r CivCiv.zip . -x '*.git*' -x 'aseprite*' -x "*.license" -x LICENSES -x make.sh -x generate-ore-jsons.elv
