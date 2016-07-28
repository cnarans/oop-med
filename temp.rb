require "pry"
require "sqlite3"

DATA = SQLite3::Database.new "data.db"
DATA.results_as_hash = true

def getRecords(name)
	entries = DATA.execute("SELECT * FROM diagnosis WHERE name = '#{name}'")
	
	for i in 0
end

def getDisease(id)
	dis = DATA.execute("SELECT name FROM disease WHERE id = #{id}")[0]["name"]
	return dis
end

def getSymptoms(id)
	symptom_ids = DATA.execute("SELECT symptom_id FROM relationship WHERE disease_id = #{id}")
	symptoms = []
	for i in 0..symptom_ids.length-1
		symptoms.push(DATA.execute("SELECT name FROM symptom WHERE id = #{symptom_ids[i][0]}")[0][0])
	end
	return symptoms
end

binding.pry

puts "Done"