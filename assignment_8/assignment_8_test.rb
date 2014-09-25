require_relative 'assignment_8'
require 'minitest/autorun'

class AdvisorTest < MiniTest::Unit::TestCase
  TEST_FILE = "./assignment_8/test_subjects.txt"

  def test_initializes_with_default_file
    a = University::Advisor.new
    subject = a.subjects["2.00"]
    assert_equal(5, subject.value)
  end

  def test_greedy_compare_value_algorithm
    a = University::Advisor.new("./assignment_8/test_subjects.txt")
    result = a.greedily_advise(max_work: 10, comparator: :value)
    assert_equal("2.03",result.keys.first )
    assert_equal("2.00", result.keys.last)
    assert_equal(2, result.size)
  end

  def test_greedy_compare_work_algorithm
    a = University::Advisor.new(TEST_FILE)
    result = a.greedily_advise(max_work: 9, comparator: :work)
    assert_equal("2.00", result.keys.first)
    assert_equal(1, result.size)
  end

  def test_greedy_compare_ratio_algorithm
    a = University::Advisor.new(TEST_FILE)
    result = a.greedily_advise(max_work: 9, comparator: :ratio)
    assert_equal("2.03", result.keys.first)
    assert_equal(3, result.size)
  end

  def test_exhaustive_algorithm_times
    a = University::Advisor.new
    a.exhaustively_advise_time(max_work:1)
    a.exhaustively_advise_time(max_work:5)
    a.exhaustively_advise_time(max_work:6)
  end

  def test_dp_algorithm_times
    a = University::Advisor.new
    a.dp_advise_time(max_work: 1)
    a.dp_advise_time(max_work: 5)
    a.dp_advise_time(max_work: 6)
  end

end
