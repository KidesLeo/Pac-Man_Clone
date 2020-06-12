extends Node

enum ENTITY_TYPES {PLAYER, GHOST}
enum ENVIR_TYPES {PILL = -3, B_PILL, WALL}


var LEFT = Vector2(-1,0)
var RIGHT = Vector2(1,0)
var DOWN = Vector2(0,1)
var UP = Vector2(0,-1)


var dir = Vector2(LEFT*10)

var PAC_START_POS = Vector2(280, 530) + dir
var GHOST_START_POS

