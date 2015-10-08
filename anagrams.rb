def first_anagram?(str1, str2)
  all_anagrams(str1).include?(str2)
end

def all_anagrams(string)
  return [string] if string.length < 2
  shorter_combs = all_combinations(string[1..-1])
  new_combs = []
  shorter_combs.each do |comb|
    0.upto(comb.length) do |pos|
      new_combs << comb[0...pos] + string[0] + comb[pos..-1]
    end
  end
  return new_combs
end

# O(n**3) - two nested loops give O(n**2), but we call this method n times

def second_anagram?(str1, str2)

  arr1 = str1.split("")
  arr2 = str2.split("")

  arr1.each_index do |idx|
    arr2.each_index do |idy|
      if arr1[idx] == arr2[idy]
        arr1[idx] = nil
        arr2[idy] = nil
      end
    end
  end

  return arr1.all?(&:nil?) && arr2.all?(&:nil?)

end

# O(n**2) - two nested loops; calls to all are each O(n) and can be neglected

def third_anagram?(str1,str2)

  str1.split("").sort == str2.split("").sort

end


# def recur_helper(str, arr)
#   return [str] if (arr.length == 0)
#   anagrams = []
#
#   arr.each do |el|
#     anagrams += recur_helper(str + el, arr.delete(el))
#   end
#
#   anagrams
# end
