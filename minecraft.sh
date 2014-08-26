#!/bin/bash

# NOTE source used in dot form here
# Alternative would be :
# source "${DIR}/connection.sh"
DIR=$( dirname ${BASH_SOURCE[0]} )
. "${DIR}/connection.sh"

### Player Functions

function player_getTilePos(){
    local msg ans
    msg="player.getTile()"
    ans=$( sendAndReceive $msg)
    echo $ans
}

function player_getPos(){
    local msg ans
    msg="player.getPos()"
    ans=$( sendAndReceive $msg)
    echo $ans
}

function player_setTilePos(){
    local msg ans x y z
    #floor any float values to integers
    x=${1%%.*}
    y=${2%%.*}
    z=${3%%.*}
    msg="player.setTile(${x},${y},${z})"
    ans=$( send $msg)
    echo $ans
}


function player_setPos(){
    local msg ans
    msg="player.setPos(${1},${2},${3})"
    ans=$( send $msg)
    echo $ans
}

function player_setting(){
    local setting status
    read setting status <<< $*
    #Set a player setting (setting, status). keys: autojump
    send "player.setting($setting, $status)"  
}

### Camera function

function camera_setNormal(){
    # Set camera mode to normal Minecraft view ([entityId])
    send "camera.mode.setNormal(${1})"
}

function camera_setFixed(){
    #  Set camera mode to fixed view
    send "camera.mode.setFixed()"
    if [ $# -eq 3 ]
    then
        camera_setPos $1 $2 $3
    fi
}

function camera_setFollow(){
    # Set camera mode to follow an entity ([entityId])
    send "camera.mode.setFollow(${1})"
}

function camera_setPos(){
    # Set camera entity position (x,y,z)
    send "camera.setPos(${1},${2},${3})"
}

### Events functions

function events_clearAll(){
    # Clear all old events
    send "events.clear()"
}

function events_pollBlockHits(){
    # Only triggered by sword => [BlockEvent]
    local s
    s=$( sendAndReceive "events.block.hits()" )
    IFS="|" read -a events <<< $s
    echo $events
}

### World functions


function getBlock(){
    local x y z
    #floor any float values to integers
    x=${1%%.*}
    y=${2%%.*}
    z=${3%%.*}
    #Get block (x,y,z) => id:int
    echo $( sendAndReceive "world.getBlock(${x},${y},${z})" )
}

function getBlockWithData(){
    local x y z response
    #floor any float values to integers
    x=${1%%.*}
    y=${2%%.*}
    z=${3%%.*}
    # Get block with data (x,y,z) => Block
    #echo $(sendAndReceive "world.getBlockWithData(${x},${y},${z})")
    echo $(sendAndReceive "world.getBlockWithData(${1},${2},${3})")
}

#    
#        TODO
#    
function getBlocks(){
    local x0 y0 z0 x1 y1 z1
    #floor any float values to integers
    x0=${1%%.*}
    y0=${2%%.*}
    z0=${3%%.*}
    x1=${4%%.*}
    y1=${5%%.*}
    z1=${6%%.*}
    # Get a cuboid of blocks (x0,y0,z0,x1,y1,z1) => [id:int]
    echo $( sendAndReceive "world.getBlocks(${x0},${y0},${z0},${x1},$y1},${z1})" )
}


function setBlock(){
    local x y z blck_id data
    x=${1%%.*}
    y=${2%%.*}
    z=${3%%.*}
    blck_id=${4%%.*}
    data=${5:-0}
    data=${data%%.*}
    echo "${x},${y},${z},${blck_id},${data}"
    #  Set block (x,y,z,id,[data])
    send "world.setBlock(${x},${y},${z},${blck_id},${data})"
}
    
function setBlocks(){
    local x0 y0 z0 x1 y1 z1 blck_id data
    #floor any float values to integers
    x0=${1%%.*}
    y0=${2%%.*}
    z0=${3%%.*}
    x1=${4%%.*}
    y1=${5%%.*}
    z1=${6%%.*}
    blck_id=${7%%.*}
    data=${8:-0}
    data=${data%%.*}
    #  Set a cuboid of blocks (x0,y0,z0,x1,y1,z1,id,[data])
    send "world.setBlocks(${x0},${y0},${z0},${x1},${y1},${z1},${blck_id},${data})"
}

function getPlayerEntityIds(){
    #   Get the entity ids of the connected players => [id:int]
    local ids idArray
    ids=$( sendAndReceive "world.getPlayerIds()" )
    IFS="|" read -a idArray <<< $ids
    echo $idArray
}

function saveCheckpoint(){
    # Save a checkpoint that can be used for restoring the world
    send "world.checkpoint.save()" 
}

function restoreCheckpoint(){
    # Restore the world state to the checkpoint
    send "world.checkpoint.restore()"
}

function setting(){
    local setting status
    read setting status <<< $*
    # Set a world setting (setting, status). keys: world_immutable, nametags_visible
    send "world.setting($setting, $status)"  
}

function postToChat(){
    send $"chat.post(${1})\\n"
}

function getHeight(){
    local x y
    #floor any float values to integers
    x=${1%%.*}
    y=${2%%.*}
    echo $( sendAndReceive "world.getHeight(${x},${y})")
}

