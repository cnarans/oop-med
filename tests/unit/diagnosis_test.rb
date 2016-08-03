
require 'test_helper'

class DiagnosisTest < Minitest::Test

  def setup
    super
    DATA.execute("DELETE FROM diagnosis")
    # This setup will automatically be run before each test below.
  end

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

  def test_load_delete
    manual=[]
    manual[0] = Diagnosis.new(nil, "Samename", '2999-12-31 23:59:59', 5)
    manual[1] = Diagnosis.new(nil, "Samename", '2939-12-31 22:59:59', 2)
    manual[0].save
    manual[1].save
    loaded_arr = Diagnosis.getRecords("Samename")
    assert_equal(loaded_arr.count, 2)
    assert_equal(manual[0].id, loaded_arr[0].id)
    assert_equal(manual[0].name, loaded_arr[0].name)
    assert_equal(manual[0].timestamp, loaded_arr[0].timestamp)
    assert_equal(manual[0].disease_id, loaded_arr[0].disease_id)
    assert_equal(manual[1].id, loaded_arr[1].id)
    assert_equal(manual[1].name, loaded_arr[1].name)
    assert_equal(manual[1].timestamp, loaded_arr[1].timestamp)
    assert_equal(manual[1].disease_id, loaded_arr[1].disease_id)
    Diagnosis.deleteRecords("Samename")
    loaded_arr = Diagnosis.getRecords("Samename")
    assert_equal(loaded_arr.count, 0)
  end

end