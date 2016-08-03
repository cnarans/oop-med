require "pry"
require "sqlite3"
require_relative "record.rb"
require_relative "diagnoser.rb"
require_relative "diagnosis.rb"

#DATA = SQLite3::Database.new "data.db"
#DATA.results_as_hash = true
#binding.pry

class Foobar
	@table = "diagnosis"
	require_relative 'medORM.rb'
	include MedORM
	extend MedORM

	
end

puts Foobar.where({"id"=>1, "name"=>"Hello World"})