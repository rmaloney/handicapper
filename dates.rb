dates = File.open("dates.txt", "r").map do |line|
	date = line.strip.split("/")
	new_date = [date[2], date[0], date[1]].join("-")
	puts new_date
end