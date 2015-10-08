require 'byebug'

class MinMaxStack
  attr_accessor :store, :sorted

  def initialize(arr = [])
    @store = arr
  end

  def pop
    el = store[-1][1]
    self.store = store[0...-1]
    el
  end

  def push(el)
    prev = peek
    if prev.nil?
      store << [el, el, el]
    else
      prev.first > el ? min = el : min = prev.first
      prev.last < el ? max = el : max = prev.last
      store << [min, el, max]
    end
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
    return nil if store.empty?
    peek.last
  end

  def min
    return nil if store.empty?
    peek.first
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
    outbox.pop[1]
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
