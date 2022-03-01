extends Node

var words = [
	"great",
	"animal",
	"keep",
	"name",
	"away",
	"together",
	"been",
	"should",
	"four",
	"every",
	"number",
	"hand",
	"again",
	"before",
	"over",
	"make",
	"grow",
	"soon",
	"begin",
	"animal",
	"your",
	"thing",
	"mean",
	"write",
	"while",
	"letter",
	"before",
	"name",
	"night",
	"must",
	"mean",
	"home",
	"which",
	"time",
	"left",
	"make",
	"year",
	"around",
	"story",
	"sometimes",
	"group",
	"took",
	"begin",
	"mother",
	"river",
	"earth",
	"some",
	"point",
	"give",
	"went",
	"give",
	"something",
	"without",
	"study",
	"miss",
	"this",
	"really",
	"family",
	"carry",
	"know",
	"took",
	"read",
	"began",
	"year",
	"feet",
	"father"
]

var special_characters = [
	".",
	"!",
	"?"
]

var current_letters = [
]


func get_prompt() -> String:
	randomize()
	var word = find_word()
	var special = find_special()
	var first_letter = word.substr(0, 1)

	while (check_for_double_first_letter(first_letter) != -1):
		word = find_word()
		first_letter = word.substr(0, 1)
	
	current_letters.append(first_letter)
	var actual_word = word
#	var actual_word = check_for_capital(word)
#	var special_character = check_for_special()
	
	return actual_word


func find_word() -> String:
	var word_index = randi() % words.size()
	var word = words[word_index]
	return word
func find_special() -> String:
	var special_index = randi() % special_characters.size()
	var special_character = special_characters[special_index]
	return special_character


func get_word_loop(word) -> String:
	var first_letter = word.substr(0, 1)
	word = find_word()
	check_for_double_first_letter(first_letter)
	return word


func check_for_double_first_letter(first_letter):
	var has_array_first_letter = current_letters.find(first_letter, 0)
	return has_array_first_letter


func check_for_capital(word) -> String:
	var actual_word = word
	var capitalize = 0
	if capitalize == 1:
		actual_word = word.substr(0, 1).to_upper() + word.substr(1).to_lower()
	return actual_word


func check_for_special(special_character) -> String:
	var specialize = 0
	return special_character
