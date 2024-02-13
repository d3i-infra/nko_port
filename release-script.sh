#!/bin/bash

# build release all individual platforms
script_location='./src/framework/processing/py/port/script.py'
single_platform='platforms = \[ ("'
single_platform_commented_out='#platforms = \[ ("'

platforms=("Youtube" "TikTok")

for platform in "${platforms[@]}"; do

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sed -i "s/$single_platform_commented_out$platform/$single_platform$platform/g" $script_location
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/$single_platform_commented_out$platform/$single_platform$platform/g" $script_location
    else
        sed -i "s/$single_platform_commented_out$platform/$single_platform$platform/g" $script_location
    fi
    PLATFORM=$platform npm run release_platform
    git restore $script_location
done
