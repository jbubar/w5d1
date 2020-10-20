class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    res = ''
    self.each do |ele|
      res += ele.hash.to_s(3)
      res += ele.hash.to_s(4)
    end
    res.to_i.hash
  end
end

class String
  def hash
    arr = []
    self.each_char do |ele|
      arr << ele.ord
    end
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
