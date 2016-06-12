require 'pry'

array1 = 
[[1, 2, 3, 4],
[5, 6, 7, 8],
[9, 10, 11, 12],
[13, 14, 15, 16]]

array2 = 
[[1,2],
[3,4],
[5,6]]

array3 = 
[[1, 2, 3, 4, 5],
[6, 7, 8, 9, 10],
[11,12,13,14,15],
[16,17,18,19,20],
[21,22,23,24,25]]

array4 =
[[9718805, 60013003, 5103628, 85388216, 21884498, 38021292, 73470430, 31785927],
[69999937, 71783860, 10329789, 96382322, 71055337, 30247265, 96087879, 93754371],
[79943507, 75398396, 38446081, 34699742, 1408833, 51189, 17741775, 53195748],
[79354991, 26629304, 86523163, 67042516, 54688734, 54630910, 6967117, 90198864],
[84146680, 27762534, 6331115, 5932542, 29446517, 15654690, 92837327, 91644840],
[58623600, 69622764, 2218936, 58592832, 49558405, 17112485, 38615864, 32720798],
[49469904, 5270000, 32589026, 56425665, 23544383, 90502426, 63729346, 35319547],
[20888810, 97945481, 85669747, 88915819, 96642353, 42430633, 47265349, 89653362],
[55349226, 10844931, 25289229, 90786953, 22590518, 54702481, 71197978, 50410021],
[9392211, 31297360, 27353496, 56239301, 7071172, 61983443, 86544343, 43779176]]

ans = 
[[93754371, 53195748, 90198864, 91644840, 32720798, 35319547, 89653362, 50410021],
[31785927, 25289229, 10844931, 97945481, 5270000, 69622764, 27762534, 43779176],
[73470430, 90786953, 42430633, 96642353, 88915819, 85669747, 26629304, 86544343],
[38021292, 22590518, 90502426, 67042516, 54688734, 32589026, 75398396, 61983443],
[21884498, 54702481, 17112485, 5932542, 29446517, 2218936, 71783860, 7071172],
[85388216, 71197978, 15654690, 58592832, 49558405, 6331115, 10329789, 56239301],
[5103628, 47265349, 54630910, 56425665, 23544383, 86523163, 96382322, 27353496],
[60013003, 63729346, 51189, 1408833, 34699742, 38446081, 71055337, 31297360],
[9718805, 38615864, 92837327, 6967117, 17741775, 96087879, 30247265, 9392211],
[69999937, 79943507, 79354991, 84146680, 58623600, 49469904, 20888810, 55349226]]

big_array = []
File.open("array.txt", "r") do |f|
  f.each_line do |line|
    big_array.push(line.split(' '))
  end
end

class Array
  # def clockwise
  #   self.reverse.transpose
  # end
  
  # def counter_clockwise
  #   self.transpose.reverse
  # end

  # def turn
  #   self.clockwise.clockwise
  # end

  # def rotate t
  #   arr = self.dup
  #   row = arr.size
  #   col = arr.first.size
  #   number_of_recrangle_edge = 4
  #   expands = []
  #   res = []
  
  #   row<col ? arr=arr.counter_clockwise : nil
  #   while arr.any?
  #     l = []
  #     number_of_recrangle_edge.times do |t|
  #       l.push(arr.shift)
  #       arr = arr.counter_clockwise
  #     end
  #     expands << l.flatten.compact
  #   end
  #   expands.reverse.each do |expand|
  #     t.times {expand.push(expand.shift)}
  #     expand.reverse!
  #     res==[] ? res = res.insert(0, expand.shift((row-col).abs+1)).transpose : nil
  #     while expand.any?
  #       res = res.clockwise
  #       res << expand.shift(res.first.size)
  #     end
  #   end

  #   res = res.turn
  #   row<col ? res=res.clockwise : nil
  #   res
  # end

  def loop_2d_array &block
    row = self.size
    col = self.first.size
    row.times do |r|
      col.times do |c|
        yield self[r][c], r, c
      end
    end
  end

  def generate_rspace
    row = self.size
    col = self.first.size
    rspace = Array.new(row){Array.new(col, nil)}
    rspace.loop_2d_array do |e, r, c|
      rspace[r][c] = [r, c]
    end
    rspace
  end

  def direction_of? rindex
    row = self.size
    col = self.first.size
    r = rindex[0]
    c = rindex[1]
    margin_left = c - 0
    margin_right = col - 1 - c
    margin_top = r - 0
    margin_buttom = row - 1 - r

    v_line = (col.to_f-1)/2
    h_line = (row.to_f-1)/2

    if r < h_line
      if c < v_line
        (margin_top < margin_left) ? ['left', margin_top] : ['down', margin_left]
      elsif c > v_line
        (margin_top <= margin_right) ? ['left', margin_top] : ['up', margin_right]
      else
        ['left', margin_top]
      end
    elsif r > h_line
      if c < v_line
        (margin_left < margin_buttom) ? ['down', margin_left] : ['right', margin_buttom]
      elsif c > v_line
        (margin_right <= margin_buttom) ? ['up', margin_right] : ['right', margin_buttom]
      else
        ['right', margin_buttom]
      end
    else
      if c > v_line
        ['up', margin_right]
      elsif c < v_line
        ['down', margin_left]
      else
        [nil, nil]
      end
    end
  end

  def recover_rspace_from rspace
    row = self.size
    col = self.first.size
    res = Array.new(row){Array.new(col, nil)}
    self.loop_2d_array do |e, r, c|
      new_index = rspace[r][c]
      res[new_index[0]][new_index[1]] = e
    end
    res
  end

  def rotate_index t
    count = 0
    row = self.size
    col = self.first.size
    rspace = self.generate_rspace
    rspace.loop_2d_array do |e, r, c|
      count += 1
      layer = rspace.direction_of?(e)[1]
      layer ? (perimeter=2*(row+col-2-4*layer)) : next
      p [layer, perimeter, t%perimeter, count]

      round = t%perimeter
      while round > 0
        direction = rspace.direction_of?(e)[0]
        case direction
        when 'left'
          step = e[1]-layer
          if round>=step
            e[1]-=step
            round -= step
          else
            e[1]-=round
            round = 0
          end
        when 'right'
          step = col-1-layer-e[1]
          if round>=step
            e[1]+=step
            round -= step
          else
            e[1]+=round
            round = 0
          end
        when 'up'
          step = e[0]-layer
          if round>=step
            e[0]-=step
            round -= step
          else
            e[0]-=round
            round = 0
          end
        when 'down'
          step = row-1-layer-e[0]
          if round>=step
            e[0]+=step
            round -= step
          else
            e[0]+=round
            round = 0
          end
        else
        end

      end
    end
    rspace
  end
end

puts big_array.recover_rspace_from(big_array.rotate_index(42971434)).map{|e|e.join(" ")}
# puts array4.recover_rspace_from(array4.rotate_index(40)).map{|e|e.join(" ")}

