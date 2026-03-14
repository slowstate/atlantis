extends Node

var icon_by_item_id: Dictionary[Ids.Items, Texture2D] = {
	Ids.Items.MiningTool: preload("uid://dv4r1124cay71"),
	Ids.Items.Glowstone: preload("uid://dasbnfj3xa38c"),
	Ids.Items.PhotonicInvertor: preload("uid://b4yj06mb3ep6n"),
}
var icon_by_note_id: Dictionary[Ids.Notes, Texture2D] = {
	Ids.Notes.ArkPlans: preload("uid://frctrf7w1n71"),
	Ids.Notes.Letter: preload("uid://cttdipbi1dljy"),
	Ids.Notes.SurvivorsJournal1: preload("uid://frctrf7w1n71"),
	Ids.Notes.SurvivorsJournal2: preload("uid://frctrf7w1n71"),
}
