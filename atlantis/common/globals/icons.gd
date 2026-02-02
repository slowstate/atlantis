extends Node

var icon_by_entity_id: Dictionary[Ids.Entities, Texture2D] = {
	Ids.Entities.MiningTool: preload("uid://cwpmv527qq3qs"),
	Ids.Entities.Glowstone: preload("uid://dyv5541unjajh"),
}
var icon_by_note_id: Dictionary[Ids.Notes, Texture2D] = {
	Ids.Notes.ArkPlans: preload("uid://cwpmv527qq3qs"),
	Ids.Notes.SurvivorsJournal: preload("uid://cwpmv527qq3qs"),
}
