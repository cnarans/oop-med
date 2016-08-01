module MedORM
	def self.find(id)
	    records = DATA.execute("SELECT * FROM #{table} WHERE id = #{id}")
	    record = records[0]

	    self.new(fields)
  	end
end