require 'test_helper'

class DiagnosisTest < Minitest::Test

  def setup
    super
    # This setup will automatically be run before each test below.
  end

  def test_diagnoser
  	doctor = Diagnoser.new
  	for i in 0..doctor.answers.count-1
  		doctor.answers[i]=true
  	end
  	verdict = doctor.diagnose()
  	doctor.resetQuestions()

  	refute_nil(verdict)

  	for answer in doctor.answers
  		assert_equal(answer, nil)
  	end
  end

 end