
require 'test_helper'

class DiseaseTest < Minitest::Test

  def test_diseasefind
    DATA.execute("INSERT INTO disease (name) VALUES ('Hyperdeath')")

    last_id = DATA.last_insert_row_id

    dis = Disease.find(last_id)

    refute_nil(dis)
    assert_equal("Hyperdeath", dis.name)
    assert_equal(last_id, dis.id)
    DATA.execute("DELETE FROM disease WHERE id==#{last_id}")
  end

  def test_diseasesave
    dis = Disease.new(nil, "Boneitis")
    dis.save
    last_id = DATA.last_insert_row_id
    dis_load = Disease.find(last_id)
    assert_equal(dis.id, dis_load.id)
    assert_equal(dis.name, dis_load.name)
    DATA.execute("DELETE FROM disease WHERE id==#{last_id}")
  end

end