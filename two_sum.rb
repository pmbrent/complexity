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
