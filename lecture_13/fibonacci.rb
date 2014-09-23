# This is an implemenation of the fibonacci sequence
# that operates in a recursive manner and does not
# use memoization.

@call_count = 0
def fib(n)
  @call_count += 1
#  puts "fib called with #{n}"
  if n <= 1
    n
  else
    fib(n-1) + fib(n-2)
  end
end

# This is a similar implementation of the fibonacci sequence
# that operates recursively but utilizes memoization.

def fast_fib(n, memo)
  @call_count += 1
#  puts "fast fib called with #{n}"
  if memo[n]
    memo[n]
  else
    memo[n] = fast_fib(n-1, memo) + fast_fib(n-2, memo)
  end
end

[5, 10, 20, 30].each do |n|
  @call_count = 0
  fib(n)
  puts "#{@call_count} calls required for n=#{n}"
  @call_count = 0
  fast_fib(n, {0=>0, 1=>1})
  puts "#{@call_count} calls required for n=#{n}"
end

