# https://github.com/seattlerb/minitest
# http://docs.seattlerb.org/minitest/Minitest/Expectations.html
require "minitest/autorun"

# class AwesomeTest < Minitest::Test 

#     def test_something
#         assert_equal(2, 1 + 1)
#     end

# end

class Vector

  attr_accessor :x, :y, :z

  def initialize(x,y,z)
    @x = x
    @y = y
    @z = z
  end

  def magnitude
    (x ** 2 + y ** 2 + z ** 2) ** (1.0 / 2.0)
  end

  def plus(vector)
    # Vector.new(x + vector.x + 1, y + vector.y + 1, z + vector.z + 1) 
    Vector.new(x + vector.x, y + vector.y, z + vector.z)
  end

  def minus(vector)
    # Vector.new(x - vector.x - 1, y - vector.y - 1, z - vector.z - 1)
    Vector.new(x - vector.x, y - vector.y, z - vector.z)
  end
end

# describe is a method provided by minitest. It is used to organize tests
# Test suite for Vector class
describe Vector do 
    # minitest also provides a method called it
    describe ".magnitude" do 
        it "calculate and return the magnitude (length) of the vector" do 
            # Given 
            # Given a new instance of a vector. This is the state of our test 
            vector = Vector.new(3, 7, 4)

            # When
            # The scenario/method you want to test
            length = vector.magnitude

            # Then
            # _is a method in minitest. Pass it the value you want to assert
            _(length).must_equal(8.602325267042627)
        end
    end

    describe ".plus" do 
        it "returns an instance of a vector" do
            # Given 
            # you use plus like this 👉 vector.plus(another_vector)
             vector_1 = Vector.new(3, 7, 4)
             vector_2 = Vector.new(3, 7, 4)

            #  When 
            added_vector = vector_1.plus(vector_2)

            # Then 
            _(added_vector).must_be_kind_of(Vector)

        end

        it "calculates the correct vector" do 
            vector_1 = Vector.new(3, 7, 4)
            vector_2 = Vector.new(3, 7, 4)

            added_vector = vector_1.plus(vector_2)

            _(added_vector.x).must_equal(6)
            _(added_vector.y).must_equal(14)
            _(added_vector.z).must_equal(8)

        end
    end
end