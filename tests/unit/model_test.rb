
require 'test_helper'

class ModelTest < Minitest::Test

  def test_diagnosisfind
    DATA.execute("INSERT INTO diagnosis (name, timestamp, disease_id) VALUES ('Josh', '2000-11-11 12:12:12',3)")

    last_id = DATA.last_insert_row_id

    diag = Diagnosis.find(last_id)

    refute_nil(diag)
    assert_equal("Josh", diag.name)
    assert_equal(last_id, diag.id)
  end

  def test_diagnosissave
    diag = Diagnosis.new(nil, "Savename", '1999-12-31 23:59:59', 4)
    diag.save
    last_id = DATA.last_insert_row_id
    diag_load = Diagnosis.find(last_id)
    assert_equal(diag.id, diag_load.id)
    assert_equal(diag.name, diag_load.name)
    assert_equal(diag.timestamp, diag_load.timestamp)
    assert_equal(diag.disease_id, diag_load.disease_id)
  end

  def test_diseasefind
    DATA.execute("INSERT INTO disease (name) VALUES ('Hyperdeath')")

    last_id = DATA.last_insert_row_id

    dis = Disease.find(last_id)

    refute_nil(dis)
    assert_equal("Hyperdeath", dis.name)
    assert_equal(last_id, dis.id)
  end

  def test_diseasesave
    dis = Disease.new(nil, "Boneitis")
    dis.save
    last_id = DATA.last_insert_row_id
    dis_load = Disease.find(last_id)
    assert_equal(dis.id, dis_load.id)
    assert_equal(dis.name, dis_load.name)
  end

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

  def test_relationshipfind
    DATA.execute("INSERT INTO relationship (disease_id, symptom_id) VALUES (1,2)")

    last_id = DATA.last_insert_row_id

    rel = Relationship.find(last_id)

    refute_nil(rel)
    assert_equal(1, rel.disease_id)
    assert_equal(2, rel.symptom_id)
    assert_equal(last_id, rel.id)
  end

  def test_relationshipsave
    rel = Relationship.new(nil, 2,3)
    rel.save
    last_id = DATA.last_insert_row_id
    rel_load = Relationship.find(last_id)
    assert_equal(rel.id, rel_load.id)
    assert_equal(rel.disease_id, rel_load.disease_id)
    assert_equal(rel.symptom_id, rel_load.symptom_id)
  end

end