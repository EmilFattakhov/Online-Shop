require "minitest/autorun"

class Rectangle 
    attr_accessor :width, :height

    def initialize(width, height)
        @width = width 
        @height = height 
    end

    def perimeter
        @width * 2 + @height * 2
    end

    def area
        @width * @height 
    end

    def is_square? 
        @width == @height
    end

end

describe Rectangle do 
    describe ".area" do 
        it "return the calculated area of the rectangle" do 
            # given 
            rect = Rectangle.new(4, 5)

            # when 
            area = rect.area 

            # then 
            _(area).must_equal(20)
        end
    end

    describe ".perimeter" do 
        it "returns the caculated perimeter of the rectangle" do 
            rect = Rectangle.new(4, 5)

            perm = rect.perimeter

            _(perm).must_equal(18)
        end
    end

    describe ".is_square?" do 
        it "returns true if the rectangle is a square" do 
            rect = Rectangle.new(7, 7)

            _(rect.is_square?).must_equal(true)
        end
    end
end