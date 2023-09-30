require "./spec_helper"

def add_one(value : Int32?) : Int32?
  guard value

  value += 1
end

def add_two(value : Int32?, op : Bool) : Int32
  guard value do
    return 0
  end

  guard op do
    raise "op should be true"
  end

  value += 2
end

it "guards against nils" do
  val : Int32? = 7

  add_one(val).should eq(8)

  add_one(6).should eq(7)
  add_one(7).should eq(8)
  add_one(nil).should eq(nil)

  expect_raises(Exception) do
    add_two(1, false).should eq(1)
  end

  add_two(nil, false).should eq(0)
  add_two(1, true).should eq(3)
  add_two(nil, true).should eq(0)
end
