require 'pry'
require 'pry-debugger'
def nest_egg_fixed(salary, percentage, growth_rate, years)
  result = []
  base = salary * percentage * 0.01
  result << base
  years -= 1
  years.times do |i|
    result << (result.last * (1 + (0.01 * growth_rate)) + salary * percentage * 0.01).round(2)
  end 
  result
end

p nest_egg_fixed(100000, 5, 3, 10) 

def nest_egg_variable(salary, percentage, growth_rates)
  result = []
  growth_rates.each do |growth_rate|
    if growth_rate == 0
      result << salary * percentage * 0.01
    else
      result << (result.last * (1 + 0.01 * growth_rate) + salary * percentage *0.01).round(2)
    end    
  end
  result
end


p nest_egg_variable(100000, 5, [0,1,3,5,-2, -1, 2, 3, 3, 4])

def post_retirement(amount, growth_rates, expenses)
  result = []
  result << amount
  growth_rates.each_with_index do |growth_rate, index|
    if index == 0
      result << ((amount * (1 + 0.01 * growth_rate)) - expenses).round(2)
    else
      result << ((result.last * ( 1 + 0.01 * growth_rate)) - expenses).round(2)
    end
  end
  result
end

p post_retirement(500000, [3, 2, 1, 0, -1, 3, 5, 7], 60000)


def findMaxExpenses(salary, percentage, career_growth_rates, retirement_growth_rates, epsilon)
  retirement = nest_egg_variable(salary, percentage, career_growth_rates).last
  puts "retirement is #{retirement}"
  guess = (0..retirement).to_a.sample
  puts "Guessing with #{guess}"
  result  = nil
  i = 0
  loop do
    i += 1
    remaining = post_retirement(retirement, retirement_growth_rates,guess).last
    puts "Left with #{remaining}"
    if remaining.abs < epsilon
      result = remaining
      break
    else
      if remaining > 0
        remaining = remaining.to_i
        guess = remaining > guess ?  (guess..remaining).to_a.sample : (remaining..guess).to_a.sample
      else
        guess = (0..guess).to_a.sample
      end
      puts "Guessing with #{guess}"
    end
  end
  puts "Spend #{guess}, that took me #{i} calculations"
end

findMaxExpenses(100000, 15, [0,3,2,-1,1,-1,2,4,5,2,3,4,3], [5,2,-3,0,1,5,2,1], 500)
