require 'benchmark'

def bad_two_sum?(arr, target)
  arr.each do |x|
    arr.each do |y|
      if x != y
        return true if (x + y == target)
      end
    end
  end

  false
end

# O(n**2) due to nested loops

def okay_two_sum?(arr, target)
  arr = arr.sort
  arr.each do |x|
    next if x == target - x  # avoid matching self
    if binary_include?(arr, target - x)
      return true
    end
  end

  false
end

def binary_include?(arr, target)
  return false if (arr.length == 1) && (arr[0] != target)

  halfway = arr.length/2

  case target <=> arr[halfway]
  when 1
    return binary_include?(arr.drop(halfway), target)
  when 0
    return true
  when -1
    return binary_include?(arr.take(halfway), target)
  end
end

# O(nlogn) - each is O(n), and we call O(logn) binary search each time

def two_sum?(arr, target)
  pairs = {}
  arr.each do |el|
    difference = target - el
    if pairs[difference]
      return true
    else
      pairs[el] = difference
    end
  end

  false
end

# O(n) at worst. ;)

def naive_three_sum?(arr, target)
    arr.each_index do |idx|
      new_arr = arr.take(idx) + arr.drop(idx + 1)
      return true if two_sum?(new_arr, target - arr[idx])
    end
    false
end

def three_sum?(arr, target)
    arr.each_index do |idx|
      new_arr = arr.take(idx) + arr.drop(idx + 1)
      return true if two_sum?(new_arr, target - arr[idx])
    end
    false
end

def x_sum?(x, arr, target)
  return two_sum?(arr, target) if x == 2
  arr.each_index do |idx|
    new_arr = arr.take(idx) + arr.drop(idx + 1)
    return true if x_sum?(x - 1, new_arr, target - arr[idx])
  end

  false
end

arr = Array.new(100) { rand(10) - 5 }

(2..5).each do |idx|
puts Benchmark.measure {

  x_sum?(idx, arr, 5000000)

}
end

# 0.000000   0.000000   0.000000 (  0.000028) => two_sum
# 0.000000   0.000000   0.000000 (  0.002203) => three_sum
# 0.210000   0.000000   0.210000 (  0.217597) => four_sum
# 21.150000   0.230000  21.380000 ( 21.526148) => five_sum, runtime increased by factor of array size.
# six_sum... still waiting....
