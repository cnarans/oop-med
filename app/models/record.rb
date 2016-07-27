class Record

	@name
	@time
	@disease
	@symptoms
	@history="records.txt"

	# default constructor
	#
	def initialize()
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

	# Sets values to given entry string
	#
	def useEntry(entry)
		entry = entry.split(",")
		@name=entry[0]
		@time=entry[1]
		@symptoms=entry[2].split(";")
		@disease=entry[3]
	end

	# writes current record to file
	#
	def writeLine()
		file = File.open(@history, "a")
		@symptoms = @symptoms.join(";")
		entry = @name + "," + @time + "," + @symptoms + "," + @disease + "\n"
		file.puts entry
		file.close
	end

	def name()
		return @name
	end

	def time()
		return @time
	end

	def symptoms()
		return @symptoms
	end

	def disease()
		return @disease
	end

	# deletes all records with specified name
	# 
	def Record.deleteAll(name)
		oldFile = File.open(@history, "r")
		goodLines = []
		while (line=oldFile.gets)
			if line.split(",")[0]!=name
				goodLines.push(line)
			end
		end
		oldFile.close
		newFile = File.open(@history, "w")
		for line in goodLines
			newFile.puts line
		end
		newFile.close
	end

	# returns array of all records for given name
	#
	def Record.returnAll(name)
		hist = File.open(@history, "r")
		all = []
		temp = Record.new
		while (line=hist.gets)
			puts line +"\n"
			temp.useEntry(line)
			if temp.name()==name
				puts temp
				all.push(temp)
			end
		end
		return all
	end

end

test = Record.returnAll("Susan")
#puts test[0].name()