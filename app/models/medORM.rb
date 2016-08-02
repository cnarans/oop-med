module MedORM

	def self.find(id)
	    records = DATA.execute("SELECT * FROM #{table} WHERE id = #{id}")
	    record = records[0]

	    self.new(fields)
  	end

  	def self.where(search)
  		where_clause=[]
  		for i in 0..search.count-1
  			where_clause.push("#{search.keys[i]}=#{search.values[i]}")
  		end
  		where_clause = where_clause.join("AND")
  		results = DATA.execute("SELECT * FROM #{table} WHERE #{where_clause}")
  		return results
  	end

end