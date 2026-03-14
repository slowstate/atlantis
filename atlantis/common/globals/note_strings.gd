extends Node

var note_titles: Dictionary[Ids.Notes, String] = {
	Ids.Notes.ArkPlans: tr("NOTE_0_ARK_PLANS_TITLE"),
	Ids.Notes.Letter: tr("NOTE_1_LETTER_TITLE"),
	Ids.Notes.SurvivorsJournal1: tr("NOTE_2_SURVIVORS_JOURNAL_TITLE"),
	Ids.Notes.SurvivorsJournal2: tr("NOTE_3_SURVIVORS_JOURNAL_TITLE"),
}
var note_content: Dictionary[Ids.Notes, String] = {
	Ids.Notes.ArkPlans: tr("NOTE_0_ARK_PLANS_CONTENT"),
	Ids.Notes.Letter: tr("NOTE_1_LETTER_CONTENT"),
	Ids.Notes.SurvivorsJournal1: tr("NOTE_2_SURVIVORS_JOURNAL_CONTENT"),
	Ids.Notes.SurvivorsJournal2: tr("NOTE_3_SURVIVORS_JOURNAL_CONTENT"),
}
