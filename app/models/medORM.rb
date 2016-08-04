module MedORM

	@table

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

	def where(search)
		where_clause=[]
		for i in 0..search.count-1
			if search.values[i].is_a? String
				where_clause.push("#{search.keys[i]}='#{search.values[i]}'")
			else
				where_clause.push("#{search.keys[i]}=#{search.values[i]}")
			end
		end
		where_clause = where_clause.join(" AND ")
		results = DATA.execute("SELECT * FROM #{@table} WHERE #{where_clause}")
		return results
	end

end