def count_sub_string_match(target, key)
  result = 0
  substring = key
  string = target
  index = 0
  count = 0
  until(index == nil)
    index = string.index(substring, index)
    if index
      index += 1
      count += 1 
    end
  end
  puts count
end


def count_subs_string_match_recursive(target, key)
  return 0 unless target
  count = 0
  index = 0
  if (index = target.index(key, index))
    count += 1
    count += count_subs_string_match_recursive(target[index+ 1..-1], key)
  end
  return count
end


count_sub_string_match("atgacatgcacaagtatgcat","atgc")
puts count_subs_string_match_recursive("atgacatgcacaagtatgcat","atgc")


def sub_string_match_exact(target, key)
  index = 0
  indices = []
  until(index == nil)
    index= target.index(key, index)
    if index
      indices << index
      index += 1
    end
  end
  p indices
end


sub_string_match_exact('atgaatgcatggatgtaaatgcag', 'atg')

def constrained_match_pair(first_sub, second_sub, length)
  result = []
  first_sub.each do |a|
    k = a + length + 1
    if second_sub.include?(k)
      result << k
    end
  end
  result
end
