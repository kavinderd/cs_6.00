
def is_prime?(number)
  range = (2..Math.sqrt(number).to_i).to_a.select { |x| x % 2 != 0 }
  prime = true
  range.each do |divisor|
    if number % divisor == 0
      prime = false
      break
    end
  end
  prime
end
prime_count =1
last_prime = 2
index = 0
candidate = 3
prime_logs = []
n = 100000
n.times do |index|
  prime_logs << Math.log(candidate) if is_prime?(candidate)
end
sum = prime_logs.inject(:+)
puts sum
puts sum / n
