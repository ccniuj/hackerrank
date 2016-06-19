require 'pry'

input = []
File.open('input.txt', 'r').each_line do |line|
  input << line.strip
end

size = input.shift
heights = input.shift.split(' ').map(&:to_i)

max_area = 0
area = 0

max_left_width = Proc.new do |arr|
  index_stack = []
  width = Array.new(heights.size){0}
  arr.size.times do |i|
    if index_stack.empty? || arr[i] >= arr[index_stack.last]
      index_stack << i
    else
      stop = false
      while index_stack.any? && !stop
        if arr[i] <= arr[index_stack.last]
          index_stack.pop
        else
          stop = true
        end
      end

      if index_stack.empty?
        width[i] = i
      else
        width[i] = i-index_stack.last-1
      end
      index_stack << i
    end
  end
  width
end

left_width = max_left_width.call(heights)
right_width = max_left_width.call(heights.reverse).reverse

heights.size.times do |i|
  width = left_width[i] + right_width[i] + 1
  area = heights[i]*width
  max_area = max_area>=area ? max_area : area
end

print max_area.to_s + "\n"
