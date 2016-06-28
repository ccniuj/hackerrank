# based on largest_rectangle.rb
require 'pry'

# input = []
# File.open('input.txt', 'r').each_line do |line|
#   input << line.strip
# end

# size = input.shift
# heights = input.shift.split(' ').map(&:to_i)

heights = [9, 6, 3, 5, 2]
max_xor = 0

left_second_mins = Proc.new do |arr|
  lbd_index_stack = []
  second_mins = Array.new(heights.size)
  arr.size.times do |i|
    second_min = nil
    if lbd_index_stack.empty? || arr[i] >= arr[lbd_index_stack.last]
      lbd_index_stack << i
      second_min = arr[i-1] if i > 0
    else
      stop = false
      while lbd_index_stack.any? && !stop
        if arr[i] <= arr[lbd_index_stack.last]
          second_min = arr[lbd_index_stack.pop]
        else
          stop = true
        end
      end

      lbd_index_stack << i
    end
    second_mins[i] = second_min
  end
  second_mins
end

left_second_min = left_second_mins.call(heights)
right_second_min = left_second_mins.call(heights.reverse).reverse

heights.size.times do |i|
  a = left_second_min[i] ? heights[i]^left_second_min[i] : -1.0/0.0
  b = right_second_min[i] ? heights[i]^right_second_min[i] : -1.0/0.0
  xor = a >= b ? a : b
  max_xor = max_xor >= xor ? max_xor : xor
end

print max_xor.to_s+"\n"
