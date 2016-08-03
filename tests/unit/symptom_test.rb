
require 'test_helper'

class SymptomTest < Minitest::Test

  def test_symptomfind
    DATA.execute("INSERT INTO symptom (name, question) VALUES ('Hyperdeath', 'Face melt')")

    last_id = DATA.last_insert_row_id

    sym = Symptom.find(last_id)

    refute_nil(sym)
    assert_equal("Hyperdeath", sym.name)
    assert_equal("Face melt", sym.question)
    assert_equal(last_id, sym.id)
  end

  def test_symptomsave
    sym = Symptom.new(nil, "Boneitis", "Crippling Boneitis")
    sym.save
    last_id = DATA.last_insert_row_id
    sym_load = Symptom.find(last_id)
    assert_equal(sym.id, sym_load.id)
    assert_equal(sym.name, sym_load.name)
    assert_equal(sym.question, sym_load.question)
  end

end