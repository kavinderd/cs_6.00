module Algorithms
  
  #Selection Sort
  # begining at element 0
  # continute checking from i through the length of the list
  # when i > an element swap the two and repeat iteration
  #Runs in O(n**2) times as it is taking a list of 'n' size and doing something n number of times
  def self.selection_sort(list)
    length =list.length - 1
    length.times do |i|
      min_val = list[i]
      min_index = i
      (i..length).to_a.each do |j|
        if min_val > list[j]
          min_val = list[j]
          min_index = j
        end
      end
      tmp = list[i]
      list[i] = min_val
      list[min_index] = tmp
    end
    list
  end

  #Bubble Sort
  # beginning at element 0
  # check against element i + 1
  # if i > i + 1, swap the two
  # then check against i + 2 and so on until the end of the list
  #Runs in O(n**2) time as it is taking a list of 'n' size and doing something to it 'n' number of times
  #Selection sort is preferable because it only makes at most one swap per iteration, wheras bubble sort could make n-1 swaps
  def self.bubble_sort(list)
    length = list.length - 1
    length.times do |j|
      length.times do |i|
        if list[i] > list[i+1]
          tmp = list[i]
          list[i] = list[i+1]
          list[i+1] = tmp
        end
      end
    end
    list
  end

  #More Efficient Bubble Sort
  # a huge drawback of bubble sort is the fact that it checks every element every time
  # even when the element before made no swamps
  # this method is slightly more efficient because in the case that it finds a sorted list earlier 
  # in the iterations it's able to return there and then
  def self.efficienter_bubble_sort(list)
    length = list.length - 1
    swapped = true
    while swapped do
      swapped = false
      length.times do |i|
        if list[i] > list[i + 1]
          list[i], list[i+1] = list[i+1], list[i]
          swapped = true
        end
      end
    end
    list
  end

end
