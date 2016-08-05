module MedORM

	@table

  # returns an object containing the information from a given database id
  #
  # id => database object of the information to be returned
  #
	def find(id)
	    records = DATA.execute("SELECT * FROM #{@table} WHERE id = #{id}")
	    record = records[0]
      fields=[]
      if record.nil?
        return nil
      else
        for i in 0..((record.count/2)-1)
          fields.push(record[i])
        end
      end
      
      self.new(*fields)
  end

  # searches the database using the given variables and comparison operator
  #
  # search => hash of terms for the SQL WHERE clause
  # operator => comparison operator for the search terms
  #
	def where(search, operator)
		where_clause=[]
		for i in 0..search.count-1
			if search.values[i].is_a? String
				where_clause.push("#{search.keys[i]}#{operator}'#{search.values[i]}'")
			else
				where_clause.push("#{search.keys[i]}#{operator}#{search.values[i]}")
			end
		end
		where_clause = where_clause.join(" AND ")
		results = DATA.execute("SELECT * FROM #{@table} WHERE #{where_clause}")
		return results
	end

end