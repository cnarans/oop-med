
require 'test_helper'

class RelationshipTest < Minitest::Test

  def test_relationshipfind
    DATA.execute("INSERT INTO relationship (disease_id, symptom_id) VALUES (1,2)")

    last_id = DATA.last_insert_row_id

    rel = Relationship.find(last_id)

    refute_nil(rel)
    assert_equal(1, rel.disease_id)
    assert_equal(2, rel.symptom_id)
    assert_equal(last_id, rel.id)

    DATA.execute("DELETE FROM relationship WHERE id==#{last_id}")
  end

  def test_relationshipsave
    rel = Relationship.new(nil, 2,3)
    rel.save
    last_id = DATA.last_insert_row_id
    rel_load = Relationship.find(last_id)
    assert_equal(rel.id, rel_load.id)
    assert_equal(rel.disease_id, rel_load.disease_id)
    assert_equal(rel.symptom_id, rel_load.symptom_id)
    DATA.execute("DELETE FROM relationship WHERE id==#{last_id}")
  end

end