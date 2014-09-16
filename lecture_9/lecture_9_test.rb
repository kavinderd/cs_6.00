require 'minitest/autorun'
require_relative 'lecture_9'

class Lecture9Test < MiniTest::Unit::TestCase

  def test_selection_sort
    list = [0,22,5,6,89,43,63,34,7]
    expected= [0, 5,6,7,22,34,43,63,89]
    actual = Algorithms.selection_sort(list)
    assert_equal(expected, actual)
  end

  def test_bubble_sort
    list = [0,22,5,6,89,43,63,34,7]
    expected= [0, 5,6,7,22,34,43,63,89]
    actual = Algorithms.bubble_sort(list)
    assert_equal(expected, actual)
  end

   def test_efficienter_bubble_sort
    list = [0,22,5,6,89,43,63,34,7]
    expected= [0, 5,6,7,22,34,43,63,89]
    actual = Algorithms.efficienter_bubble_sort(list)
    assert_equal(expected, actual)
  end


end
