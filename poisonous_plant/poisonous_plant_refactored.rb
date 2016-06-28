# refactored version
input = []
File.open('input.txt', 'r').each_line do |line|
  input << line.strip
end

n = input.shift
poisons = input.shift.split(' ').map(&:to_i)

killer_stack = []
max_life = 0

poisons.each do |poison|
  life = 1
  while !killer_stack.empty? && killer_stack.last[0]>=poison
    life = [killer_stack.pop[1]+1, life].max
  end

  if killer_stack.empty?
    life = 1
  end

  max_life=[max_life, life].max
  killer_stack.push([poison, life])
end

puts max_life