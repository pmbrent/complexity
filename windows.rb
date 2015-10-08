load 'stacks_and_queues.rb'
require 'benchmark'

def bad_windowed_max_range(arr, w)
  current_max_range = 0

  0.upto(arr.size - w).each do |first|
    wmax = arr[first, w].max
    wmin = arr[first, w].min
    current_range = wmax - wmin

    if current_range > current_max_range
      current_max_range = current_range
    end
  end

  current_max_range
end

# O(n * 2w) or O(nw) time

def windowed_max_range1(arr, w)
  current_max_range = 0

  0.upto(arr.size - w).each do |first|
    wmax = arr[first, w].last
    wmin = arr[first, w].first
    current_range = wmax - wmin

    if current_range > current_max_range
      current_max_range = current_range
    end
  end

  current_max_range
end

# O(n) time; takes advantage of having a sorted array (max is last, min is first)

def windowed_max_range(arr, w)
  queue = MinMaxStackQueue.new
  (0...w).each do |idx|
    queue.enqueue(arr[idx])
  end
  max_range = queue.max - queue.min

  w.upto(arr.size - 1).each do |idx|
    queue.enqueue(arr[idx])
    queue.dequeue
    current_range = queue.max - queue.min
    max_range = current_range if current_range > max_range
  end

  max_range
end

# O(n * logw) - we iterate over all n elts but only ever binary sort on w elts

arr = Array.new(100000) { rand(1000) - 500 }
puts Benchmark.measure {

  p bad_windowed_max_range(arr, 100)
}

puts Benchmark.measure {

  p windowed_max_range(arr, 100)

}
