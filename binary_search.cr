require "spec"

module BinarySearch
  def self.call(ary, target)
    min = 0
    max = ary.size - 1

    while min <= max
      guess = (min + max / 2).to_i

      if ary[guess] == target
        return guess
      elsif ary[guess] < target
        min = guess + 1
      else
        max = guess - 1
      end
    end

    return -1
  end
end

describe "BinarySearch" do
  it "empty array" do
    result = BinarySearch.call([] of Int32, 1)
    result.should eq -1
  end

  describe "target is greater than max element" do
    it "returns -1" do
      result = BinarySearch.call([2] of Int32, 3)
      result.should eq -1
    end
  end

  describe "target is lower than min element" do
    it "returns -1" do
      result = BinarySearch.call([1], 0)

      result.should eq -1
    end

    describe "the only element == target" do
      it "returns 0" do
        result = BinarySearch.call([1], 1)

        result.should eq 0
      end
    end
  end

  describe "target lower than max and higher than min and doesn't exist" do
    it "returns -1" do
      result = BinarySearch.call([1, 4, 7, 8, 14], 3)

      result.should eq -1
    end
  end

  describe "target lower than max and higher than min and exists" do
    it "returns -1" do
      result = BinarySearch.call([1, 4, 7, 8, 14], 7)

      result.should eq 2 
    end
  end
end
