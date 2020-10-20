class MaxIntSet
  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max){false}
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num >= 0 && num < max
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    location = num % num_buckets #gives the bucket that it goes into
    @store[location] << num unless @store[location].include?(num)
  end
  
  def remove(num)
    location = num % num_buckets #gives the bucket that it goes into
    @store[location].delete(num)
  end
  
  def include?(num)
    location = num % num_buckets #gives the bucket that it goes into
    if self[location].include?(num)
      true 
    else
      false
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet < IntSet
  attr_reader :count
  attr_accessor :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    resize! if @count >= num_buckets 
    @count += 1 unless self.include?(num)
    super
  end

  def remove(num)
    @count -= 1 if self.include?(num)
    super
  end

  def include?(num)
    location = num % num_buckets #gives the bucket that it goes into
    if self[location].include?(num)
      true 
    else
      false
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    super
  end

  def resize!
    @num_buckets *= 2
    old_store = @store.dup
    @store = Array.new(@num_buckets){Array.new}
    @count = 0
    
    old_store.each do |bucket| 
      bucket.each {|num| insert(num)} 
    end
  end
end
