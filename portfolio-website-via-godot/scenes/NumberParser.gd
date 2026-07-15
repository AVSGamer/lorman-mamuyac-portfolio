extends RefCounted
class_name NumberParser

static var ones = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
static var teens = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
static var tens = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]

# Generates a random number pair based on difficulty tier (1 to 4 digits)
static func generate_pair(difficulty_tier: int) -> Dictionary:
	var num: int = 0
	
	match difficulty_tier:
		1: num = randi_range(0, 19)          # Simple single digits & basic teens
		2: num = randi_range(20, 99)         # Up to two digits
		3: num = randi_range(100, 999)       # Three digits (Hundreds)
		_: num = randi_range(1000, 9999)     # Boss mode: Four digits (Thousands)
		
	return {"word": int_to_words(num), "num": str(num)}

# Converts raw integers to English word strings
static func int_to_words(n: int) -> String:
	if n == 0: return ones[0]
	return _parse_number(n).strip_edges()

static func _parse_number(n: int) -> String:
	if n < 10:
		return ones[n]
	elif n < 20:
		return teens[n - 10]
	elif n < 100:
		var suffix = ""
		if n % 10 != 0: suffix = "-" + ones[n % 10]
		return tens[n / 10] + suffix
	elif n < 1000:
		var suffix = ""
		if n % 100 != 0: suffix = " " + _parse_number(n % 100)
		return ones[n / 100] + " hundred" + suffix
	else:
		var suffix = ""
		if n % 1000 != 0: suffix = " " + _parse_number(n % 1000)
		return _parse_number(n / 1000) + " thousand" + suffix
