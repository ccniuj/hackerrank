require 'pry'
str = 'djjcddjggbiigjhfghehhbgdigjicafgjcehhfgifadihiajgciagicdahcbajjbhifjiaajigdgdfhdiijjgaiejgegbbiigida'
ans = 'aaaaabccigicgjihidfiejfijgidgbhhehgfhjgiibggjddjjd'

str_count = Hash.new{|h,k|h[k]=0}
last_char = ''
breaks = []
str.size.times do |t|
  c = str[t]
  str_count[c] += 1
  breaks<<(t-1) if last_char != '' && c > last_char
  last_char = c
end
boundary_count = Hash[str_count.map{|k,v|[k,v/2]}]

grabs = []
grab_count = Hash.new{|h,k|h[k]=0}
drop_count = Hash.new{|h,k|h[k]=0}
s_i = 0
e_i = str.size - 1

while e_i
  s_i = e_i
  e_i = breaks.size>0 ? breaks.pop : nil
  
  valids = []
  sub_str_size = e_i ? s_i-e_i : s_i+1
  drop_buffer = Hash.new{|h,k|h[k]=[]}
  sub_str_size.times do |t|
    s = str[s_i-t]
    if grab_count[s] < boundary_count[s]
      valids.unshift(s)
      grab_count[s] += 1
    else
      valids.unshift('')
      drop_buffer[s] << t
      drop_count[s] += 1
    end
  end

  c = valids.reject(&:empty?)[-1]
  saturated = false
  while c && grabs.size > 0 && c < grabs[0] && !saturated
    d = grabs[0]
    if drop_count[d] < boundary_count[d]
      grabs.shift
      grab_count[d] -= 1
      drop_count[d] += 1
    else
      if drop_buffer[d].any?
        grabs.shift
        i = drop_buffer[d].pop
        valids[-1-i] = d
      else
        saturated = true
      end
    end
  end
  
  valids.delete('')
  grabs = valids.concat(grabs)
end

grabs = grabs.join.reverse
print grabs+"\n"