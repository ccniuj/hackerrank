require 'pry'

# input = []
# File.open('input.txt', 'r').each_line do |line|
#   input << line.strip
# end

# n = input.shift
# poisons = input.shift.split(' ').map(&:to_i)

# poisons = [1, 3, 5, 2, 7, 6, 4, 2, 1]
# poisons = [6, 5, 8, 4, 7, 10, 9, 5]
# poisons = [1, 2, 3, 4, 5]
# poisons = [1, 1, 1, 1, 1]
# poisons = [20, 5, 6, 15, 2, 2, 17, 2, 11, 5, 14, 5, 10, 9, 19, 12, 5]
poisons = [3, 7, 1, 2, 4, 8, 2, 7, 10]

killers_index_stack = []
day_survived = Array.new(poisons.size){1}
day_survived[0] = 1.0/0.0
day_passed = 0
max_day_survived = 0
poisons.size.times do |i|
  if killers_index_stack.empty? || poisons[i] > poisons[killers_index_stack.last]
    killers_index_stack << i
    day_passed = 0
  else
    stop = false
    while killers_index_stack.any? && !stop
      k_i = killers_index_stack.last
      if poisons[i] < poisons[k_i]
        if day_survived[k_i]==1.0/0.0
          day_survived[i] = 1.0/0.0
          stop = true
        else
          killers_index_stack.pop
          if day_survived[k_i] > day_passed
            day_passed += (day_survived[k_i]-day_passed)
          end
        end
      elsif poisons[i]==poisons[k_i]
        if day_survived[k_i]==1.0/0.0
          day_survived[i] = 1.0/0.0
        else
          if day_survived[k_i] > day_passed
            day_passed += 1
          end
        end
        stop = true
      else
        stop = true
      end
    end
    day_survived[i] += day_passed
    killers_index_stack << i
  end
end

day_survived.delete(1.0/0.0)
if day_survived.any?
  max_day_survived = day_survived.max
else
  max_day_survived = 0
end

print max_day_survived.to_s + "\n"
