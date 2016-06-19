require 'pry'

strs = []
File.open('input.txt', 'r') do |f|
  f.each_line do |line|
    strs << line.strip
  end
end

str1 = strs[0]
str2 = strs[1]

n = str1.size
m = str2.size
counts = Array.new(m+1){|a|0}
str2_map = Hash.new{|h, k|h[k]=[]}
str2.split('').each_with_index{|s, i|str2_map[s] << i}

n.times do |t|
  index_of_same_char = str2_map[str1[t]]
  index_of_same_char.each_index do |i|
    index = index_of_same_char[-1-i]
    counts[index+1] = counts[index] + 1
  end
  
  index_of_same_char.each_index do |i|
    start_i = index_of_same_char[i]
    end_i = index_of_same_char[i+1] ? index_of_same_char[i+1] : m
    v = counts[start_i+1]
    u = counts[start_i+2]
    if !u || v <= u
      next
    else
      (start_i+1..end_i-1).each do |c|
        if v==counts[c+1]
          break
        else
          counts[c+1] = v
        end
      end
    end
  end
  
  # general solution with complexity of O(n*m)
  # m.times do |j|
  #   p [i, j]
  #   if str1[i]==str2[j]
  #     count_map[i+1][j+1] = count_map[i][j] + 1
  #   else
  #     count_map[i+1][j+1] = [count_map[i][j+1], count_map[i+1][j]].max
  #   end
  # end
end

p counts[m]