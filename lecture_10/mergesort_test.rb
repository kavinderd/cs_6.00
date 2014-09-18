require 'minitest/autorun'
require_relative 'mergesort'

class MergesortTest < MiniTest::Unit::TestCase
  
  def test_merging_an_unsorted_array
    array = [53,26,204,1,4,34,66,20,3,84,0]
    result = Algorithms.mergesort(array)
    assert_equal(array.sort, result)
  end

end
