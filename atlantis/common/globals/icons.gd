extends Node

var icon_by_item_id: Dictionary[Ids.Items, Texture2D] = {
	Ids.Items.MiningTool: preload("uid://cwpmv527qq3qs"),
	Ids.Items.Glowstone: preload("uid://dyv5541unjajh"),
	Ids.Items.Diode: preload("uid://dyv5541unjajh"),
}
var icon_by_note_id: Dictionary[Ids.Notes, Texture2D] = {
	Ids.Notes.ArkPlans: preload("uid://cwpmv527qq3qs"),
	Ids.Notes.SurvivorsJournal: preload("uid://cwpmv527qq3qs"),
}
