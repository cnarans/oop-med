require "pry"
require "sqlite3"
require_relative "record.rb"
require_relative "diagnoser.rb"

DATA = SQLite3::Database.new "data.db"
DATA.results_as_hash = true

binding.pry