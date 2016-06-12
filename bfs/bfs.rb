require 'pry'

inputs  = File.open('input2.txt','r').gets(nil).split("\n")
outputs = File.open('output2.txt','r').gets(nil).split("\n")

# t = gets.strip.to_i
t = inputs.shift.strip.to_i
t.times do |i|
  # num_of_node, num_of_edge = gets.strip.split(' ').map(&:to_i)
  num_of_node, num_of_edge = inputs.shift.strip.split(' ').map(&:to_i)

  edges = Array.new(num_of_node){[]}

  num_of_edge.times do
    # p, q = gets.strip.split(' ').map(&:to_i)
    p, q = inputs.shift.strip.split(' ').map(&:to_i)
    edges[p-1].push(q)
    edges[q-1].push(p)
  end
  edges.each{|e|e.uniq!}

  # origin = gets.strip.to_i
  origin = inputs.shift.strip.to_i
  
  traversed_nodes = Array.new(num_of_node)
  on_verge_nodes = [origin]
  boundary = 1
  distance = 0

  while on_verge_nodes.compact.size > 0
    vn = on_verge_nodes.shift.tap{ |n|traversed_nodes[n-1] = distance }
    next_verge_nodes = edges[vn-1].map do |v|
                         !traversed_nodes[v-1] ? (!on_verge_nodes.include?(v) ? v : nil) : nil
                       end.compact
    on_verge_nodes.concat(next_verge_nodes)
    if traversed_nodes.compact.size == boundary
      boundary += on_verge_nodes.size
      distance += 6
    end
  end

  traversed_nodes.delete_at(origin-1)
  traversed_nodes = traversed_nodes.map{ |tn|tn ? tn : -1 }
  print traversed_nodes.join(' ')
  print "\n"
end
