# This is an implementation of a decision tree 
# that solves the knapsack problem.
# w = weight of item
# v = value of item
# i = index of list
# aW = the weight taken up to that point

@call_count = 0
def max_val(w, v, i, aW)
  @call_count += 1
  if i == 0
    if w[i] <= aW
      # If we're at the bottom of the tree and there is still enough room for i take it
      return v[i]
    else
      return 0
    end
  end
  # Remainder of tree if i is not chosen
  without_i = max_val(w, v, i-1, aW)
  # if weight of i is larger than allowance we can't take it
  if w[i] > aW
    return without_i
  else
    with_i = v[i] + max_val(w, v, i-1, aW-w[i])
  end
  return [with_i, without_i].max
end

# This is a similar implementation of a decision tree
# for the knapsack problem, but it utilizes memoization
def faster_max_val(w, v, i, aW, m)
  @call_count += 1
  if m[[i, aW]]
    return m[[i, aW]]
  else
    if i==0
      if w[i] <= aW
        return m[[i, aW]] = v[i]
      else
        return m[[i, aW]] = 0
      end
    end
    without_i = faster_max_val(w, v, i-1, aW, m)
    if w[i] > aW
      return m[[i, aW]] = without_i
    else
      with_i = v[i] + faster_max_val(w, v, i-1, aW - w[i] , m)
    end
    result = [with_i, without_i].max
    m[[i, aW]] = result
  end
end

weights = [1,1,5,5,3,3,4,4]
values  = [15,15,10,10,9,9,5,5]
@call_count = 0

res = max_val(weights, values, values.length - 1, 14)
puts "max val #{res} number of calls #{@call_count}"

@call_count = 0
res = faster_max_val(weights, values, values.length - 1, 14, {})
puts "max val #{res} number of calls #{@call_count}"

weights = [1,4,2,5,6,3,6,3,4,5,7,3,2,1,3,5,7,8,4,2,3]
values  = [3,7,3,5,7,3,7,8,3,2,8,5,3,1,5,6,3,1,4,8,5]

@call_count = 0

res = max_val(weights, values, values.length - 1, 14)
puts "max val #{res} number of calls #{@call_count}"

@call_count = 0
res = faster_max_val(weights, values, values.length - 1, 14, {})
puts "max val #{res} number of calls #{@call_count}"
