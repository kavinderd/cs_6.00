module Algorithms
  extend self

  #Mergesort
  # The purpose of this algorithm is to take an array of N length
  # Break it down into smaller and smaller pieces until the complexity
  # of sorting a sub-array is a basic operation.
  # Then to take sorted sub-arrays and merge them back together
  # This array runs in nlog(n) time because it takes about n steps to merge all the sub-arrays
  # and it requires log(n) time to sort the whole array
  def mergesort(array)
    if array.length == 1
      array
    else
      mid = array.length / 2
      sub_ar1 = mergesort(array.slice(0...mid))
      sub_ar2 = mergesort(array.slice(mid..(array.length - 1)))
      merge(sub_ar1, sub_ar2)
    end
  end

  def merge(part1, part2)
    result = []
    i = 0
    j = 0
    while i < part1.length && j < part2.length
      a = part1[i]
      b = part2[j]
      if a < b
        result << a
        i += 1
      else
        result << b
        j += 1 
      end
    end  
    while i < part1.length
      result << part1[i]
      i+=1
    end
    while j < part2.length
      result << part2[j]
      j+=1
    end
    result
  end
end
