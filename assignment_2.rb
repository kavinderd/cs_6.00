#This is an exhaustive enumeration approach to solving 6a + 9b + 20c = n
def nugget_combination_required(n)
  set = [6, 9, 20]
  (0..n).each do |a|
    (0..n).each do |b|
      (0..n).each do |c|
        result = (set[0] * a) + (set[1] * b) + (set[2] * c) 
        if result == n
          puts "For #{n} you'll need #{a} of the 6 nuggets, #{b} of the 9, and #{c} of the 20"
        end
      end
    end
  end
end

(50..55).to_a.each do |n|
  puts nugget_combination_required(n)
end

def largest_inexact_quantity
  n = 6
  list = [] 
  set = [6,9,20]
  consecutive = 0
  loop do
    list << n
    found = false
    (0..n).each do |a|
      (0..n).each do |b|
        (0..n).each do |c|
          result= (set[0] * a) + (set[1] * b) + (set[2] * c )
          if result == n
            list.delete(n)
            consecutive += 1
          end
        end
      end
    end
    break if consecutive == 6
    consecutive = 0 unless list.include?(n)
    n += 1
  end
  puts "Larges value is #{list.last}"
end

puts largest_inexact_quantity

def largest_quantity_for_variable_package_size(x, y, z)
  set = [x,y,z]
  max = 200 / z
  largest = 0
  (0..max).each do |a|
    (0..max).each do |b|
      (0..max).each do |c| 
        result = (set[0] * a) + (set[1] * b) + (set[2] * c)
        break if result >= 200
        largest = result if result > largest
      end
    end
  end
  largest
end

puts largest_quantity_for_variable_package_size(6, 9, 20)
puts largest_quantity_for_variable_package_size(4, 5, 10)
puts largest_quantity_for_variable_package_size(4, 5, 7)
