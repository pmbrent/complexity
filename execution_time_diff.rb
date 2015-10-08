# def my_min(list)
#
#   list.each do |el|
#     return el if list.all? do |el2|
#       el2 >= el
#     end
#   end
# end

# This is O(n**2) due to the nested loop (iterates through twice)

def my_min(list)

  min = list[0]

  list.each do |el|
    if el < min
      min = el
    end
  end

  min
end

# This is O(n) as it iterates only once through the list

def l_c_sub_sum_slow(arr)

  container = []

  0.upto(arr.length - 1) do |idx|
    (idx + 1..arr.count).each do |idx2|
      container << arr[idx..idx2]
    end
  end
  sums = container.map do |x|
            x.inject(&:+)
          end

  sums.max
end


# This is O(n**2) due to the nested loop (iterates through twice).
#Other O(n) operations are negligible.

def l_c_sub_sum(arr)

  current_sum = 0
  best_sum = arr[0]

  arr.each_index do |idx|
    current_sum = current_sum + arr[idx]
    if current_sum < 0
      current_sum = 0
    elsif current_sum > best_sum
      best_sum = current_sum
    elsif arr[idx] > best_sum
      best_sum = arr[idx]
      current_sum = best_sum
    end
    # puts "idx: #{idx}"
    # puts "current_sum: #{current_sum}"
    # puts "best_sum: #{best_sum}"
  end

  best_sum
end

# A single loop of length n containing only constant-time operations => O(n**2)
# Two FixNums => O(1) memory
