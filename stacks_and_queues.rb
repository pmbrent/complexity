require 'byebug'

class MinMaxStack
  attr_accessor :store, :sorted

  def initialize(arr = [])
    @store = arr
    @sorted = []
  end

  def pop
    el = store[-1]
    self.store = store[0...-1]
    remove_from_sorted(el)
    el
  end

  def push(el)
    store << el
    add_to_sorted(el)
  end

  def peek
    store[-1]
  end

  def size
    store.length
  end

  def empty?
    store.length < 1
  end

  def max
    sorted.last
  end

  def min
    sorted.first
  end

  def add_to_sorted(el)
    if sorted.empty?
      sorted << el
    else
      idx = retrieve_index(sorted.dup, el)
      sorted.insert(idx, el)
    end
  end

  def remove_from_sorted(el)
    idx = retrieve_index(sorted.dup, el)
    sorted.delete_at(idx)
  end

  def retrieve_index(arr, el)
    if arr.length <= 1
      return 0 if arr[0] >= el
      return 1 if arr[0] < el  # danger if trying to remove nonexistent el
    end

    halfway = arr.length / 2

    case el <=> arr[halfway]
    when 1
      return halfway + retrieve_index(arr.drop(halfway), el)
    when 0
      return halfway
    when -1
      return retrieve_index(arr.take(halfway), el)
    end
  end

end

class MinMaxStackQueue
  attr_accessor :inbox, :outbox

  def initialize()
    @inbox = MinMaxStack.new
    @outbox = MinMaxStack.new
  end

  def enqueue(el)
    inbox.push(el)
    nil
  end

  def dequeue
    if outbox.empty?
      slinky
    end
    outbox.pop
  end

  def size
    inbox.size + outbox.size
  end

  def empty?
    inbox.empty? && outbox.empty?
  end

  def slinky
    until inbox.empty?
      outbox.push(inbox.pop)
    end
  end

  def max
    return inbox.max if outbox.empty?
    return outbox.max if inbox.empty?
    inbox.max > outbox.max ? inbox.max : outbox.max
  end

  def min
    return inbox.min if outbox.empty?
    return outbox.min if inbox.empty?
    inbox.min < outbox.min ? inbox.min : outbox.min
  end
end
