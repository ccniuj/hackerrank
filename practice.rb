require 'pry'

str1 = 'SHINCHAN'
str2 = 'NOHARAAA'
str1 = 'ABCDEF'
str2 = 'FBDAMN'

n = str1.size
m = str2.size
count_map = Array.new(n+1){|a|Array.new(m+1){0}}
n.times do |i|
  m.times do |j|
    if str1[i]==str2[j]
      count_map[i+1][j+1] = count_map[i][j] + 1
    else
      count_map[i+1][j+1] = [count_map[i][j+1], count_map[i+1][j]].max
    end
  end
end

print count_map[n][m].to_s + "\n"