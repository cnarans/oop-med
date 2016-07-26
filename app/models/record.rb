class Record

	@name
	@time
	@disease
	@symptoms

	# default constructor
	#
	def initialize()
		@history = "records.txt"
	end

	# Sets the name of the file to which records will be stored
	#
	# filename -> string containing the filename
	#
	def setHistory(filename)
		@history = filename
	end

	# Sets values to a specific line in the file
	#
	def loadLine(line)
		file = File.open(@history, "r")
		for i in 0..line
			entry = file.gets
		end
		entry = entry.split(",")
		@name=entry[0]
		@time=entry[1]
		@symptoms=entry[2].split(";")
		@disease=entry[3]
		file.close
	end

	def writeLine()
		file = File.open(@history, "a")
		@symptoms = @symptoms.join(";")
		entry = @name + "," + @time + "," + @symptoms + "," + @disease + "\n"
		return entry
	end

end

test = Record.new
test.loadLine(2)
puts test.writeLine()