#!/bin/bash
    
# Only source blockData if  hasn't already been sourced
# can't redeclare readonly variables
if [[ $BLOCK_DATA_HAS_BEEN_SOURCED -ne 1 ]]
then
    # NOTE source used in dot form here
    # Alternative would be :
    # source "${DIR}/connection.sh"
    DIR=$( dirname ${BASH_SOURCE[0]} )
    . "${DIR}/block.sh"
    
    declare BLOCK_DATA_HAS_BEEN_SOURCED=1
    declare -A blockIdToName
    blockIdToName=(  \
       ["${AIR[${BLOCK_ID}]}"]='AIR'    \
       ["${STONE[${BLOCK_ID}]}"]='STONE'    \
       ["${GRASS[${BLOCK_ID}]}"]='GRASS'    \
       ["${DIRT[${BLOCK_ID}]}"]='DIRT'    \
       ["${COBBLESTONE[${BLOCK_ID}]}"]='COBBLESTONE'    \
       ["${WOOD_PLANKS[${BLOCK_ID}]}"]='WOOD_PLANKS'    \
       ["${SAPLING[${BLOCK_ID}]}"]='SAPLING'    \
       ["${BEDROCK[${BLOCK_ID}]}"]='BEDROCK'    \
       ["${WATER_FLOWING[${BLOCK_ID}]}"]='WATER_FLOWING'    \
       ["${WATER_STATIONARY[${BLOCK_ID}]}"]='WATER_STATIONARY'    \
       ["${LAVA_FLOWING[${BLOCK_ID}]}"]='LAVA_FLOWING'    \
       ["${LAVA_STATIONARY[${BLOCK_ID}]}"]='LAVA_STATIONARY'    \
       ["${SAND[${BLOCK_ID}]}"]='SAND'    \
       ["${GRAVEL[${BLOCK_ID}]}"]='GRAVEL'    \
       ["${GOLD_ORE[${BLOCK_ID}]}"]='GOLD_ORE'    \
       ["${IRON_ORE[${BLOCK_ID}]}"]='IRON_ORE'    \
       ["${COAL_ORE[${BLOCK_ID}]}"]='COAL_ORE'    \
       ["${WOOD[${BLOCK_ID}]}"]='WOOD'    \
       ["${LEAVES[${BLOCK_ID}]}"]='LEAVES'    \
       ["${GLASS[${BLOCK_ID}]}"]='GLASS'    \
       ["${LAPIS_LAZULI_ORE[${BLOCK_ID}]}"]='LAPIS_LAZULI_ORE'    \
       ["${LAPIS_LAZULI_BLOCK[${BLOCK_ID}]}"]='LAPIS_LAZULI_BLOCK'    \
       ["${SANDSTONE[${BLOCK_ID}]}"]='SANDSTONE'    \
       ["${BED[${BLOCK_ID}]}"]='BED'    \
       ["${COBWEB[${BLOCK_ID}]}"]='COBWEB'    \
       ["${GRASS_TALL[${BLOCK_ID}]}"]='GRASS_TALL'    \
       ["${WOOL[${BLOCK_ID}]}"]='WOOL'    \
       ["${FLOWER_YELLOW[${BLOCK_ID}]}"]='FLOWER_YELLOW'    \
       ["${FLOWER_CYAN[${BLOCK_ID}]}"]='FLOWER_CYAN'    \
       ["${MUSHROOM_BROWN[${BLOCK_ID}]}"]='MUSHROOM_BROWN'    \
       ["${MUSHROOM_RED[${BLOCK_ID}]}"]='MUSHROOM_RED'    \
       ["${GOLD_BLOCK[${BLOCK_ID}]}"]='GOLD_BLOCK'    \
       ["${IRON_BLOCK[${BLOCK_ID}]}"]='IRON_BLOCK'    \
       ["${STONE_SLAB_DOUBLE[${BLOCK_ID}]}"]='STONE_SLAB_DOUBLE'    \
       ["${STONE_SLAB[${BLOCK_ID}]}"]='STONE_SLAB'    \
       ["${BRICK_BLOCK[${BLOCK_ID}]}"]='BRICK_BLOCK'    \
       ["${TNT[${BLOCK_ID}]}"]='TNT'    \
       ["${BOOKSHELF[${BLOCK_ID}]}"]='BOOKSHELF'    \
       ["${MOSS_STONE[${BLOCK_ID}]}"]='MOSS_STONE'    \
       ["${OBSIDIAN[${BLOCK_ID}]}"]='OBSIDIAN'    \
       ["${TORCH[${BLOCK_ID}]}"]='TORCH'    \
       ["${FIRE[${BLOCK_ID}]}"]='FIRE'    \
       ["${STAIRS_WOOD[${BLOCK_ID}]}"]='STAIRS_WOOD'    \
       ["${CHEST[${BLOCK_ID}]}"]='CHEST'    \
       ["${DIAMOND_ORE[${BLOCK_ID}]}"]='DIAMOND_ORE'    \
       ["${DIAMOND_BLOCK[${BLOCK_ID}]}"]='DIAMOND_BLOCK'    \
       ["${CRAFTING_TABLE[${BLOCK_ID}]}"]='CRAFTING_TABLE'    \
       ["${FARMLAND[${BLOCK_ID}]}"]='FARMLAND'    \
       ["${FURNACE_INACTIVE[${BLOCK_ID}]}"]='FURNACE_INACTIVE'    \
       ["${FURNACE_ACTIVE[${BLOCK_ID}]}"]='FURNACE_ACTIVE'    \
       ["${DOOR_WOOD[${BLOCK_ID}]}"]='DOOR_WOOD'    \
       ["${LADDER[${BLOCK_ID}]}"]='LADDER'    \
       ["${STAIRS_COBBLESTONE[${BLOCK_ID}]}"]='STAIRS_COBBLESTONE'    \
       ["${DOOR_IRON[${BLOCK_ID}]}"]='DOOR_IRON'    \
       ["${REDSTONE_ORE[${BLOCK_ID}]}"]='REDSTONE_ORE'    \
       ["${SNOW[${BLOCK_ID}]}"]='SNOW'    \
       ["${ICE[${BLOCK_ID}]}"]='ICE'    \
       ["${SNOW_BLOCK[${BLOCK_ID}]}"]='SNOW_BLOCK'    \
       ["${CACTUS[${BLOCK_ID}]}"]='CACTUS'    \
       ["${CLAY[${BLOCK_ID}]}"]='CLAY'    \
       ["${SUGAR_CANE[${BLOCK_ID}]}"]='SUGAR_CANE'    \
       ["${FENCE[${BLOCK_ID}]}"]='FENCE'    \
       ["${GLOWSTONE_BLOCK[${BLOCK_ID}]}"]='GLOWSTONE_BLOCK'    \
       ["${BEDROCK_INVISIBLE[${BLOCK_ID}]}"]='BEDROCK_INVISIBLE'    \
       ["${STONE_BRICK[${BLOCK_ID}]}"]='STONE_BRICK'    \
       ["${GLASS_PANE[${BLOCK_ID}]}"]='GLASS_PANE'    \
       ["${MELON[${BLOCK_ID}]}"]='MELON'    \
       ["${FENCE_GATE[${BLOCK_ID}]}"]='FENCE_GATE'    \
       ["${GLOWING_OBSIDIAN[${BLOCK_ID}]}"]='GLOWING_OBSIDIAN'    \
       ["${NETHER_REACTOR_CORE[${BLOCK_ID}]}"]='NETHER_REACTOR_CORE'    \
    )
    
    function BlockData_getBlockNameFromId(){
          echo ${blockIdToName[$1]}
    }
fi
