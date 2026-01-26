extends Node

var IconByEntityId: Dictionary[Ids.Entities, Texture2D] = {
	Ids.Entities.Glowstone: preload("uid://dyv5541unjajh"),
	Ids.Entities.MiningTool: preload("uid://cwpmv527qq3qs"),
}
var IconByNoteId: Dictionary[Ids.Notes, Texture2D] = {
	Ids.Notes.ArkPlans: preload("uid://cwpmv527qq3qs"),
}
