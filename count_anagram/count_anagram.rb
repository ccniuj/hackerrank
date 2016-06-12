require 'pry'
require 'awesome_print'

strs = 
['aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
'bbcaadacaacbdddcdbddaddabcccdaaadcadcbddadababdaaabcccdcdaacadcababbabbdbacabbdcbbbbbddacdbbcdddbaaa',
'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
'cacccbbcaaccbaacbbbcaaaababcacbbababbaacabccccaaaacbcababcbaaaaaacbacbccabcabbaaacabccbabccabbabcbba',
'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
'bbcbacaabacacaaacbbcaabccacbaaaabbcaaaaaaaccaccabcacabbbbabbbbacaaccbabbccccaacccccabcabaacaabbcbaca',
'cbaacdbaadbabbdbbaabddbdabbbccbdaccdbbdacdcabdbacbcadbbbbacbdabddcaccbbacbcadcdcabaabdbaacdccbbabbbc',
'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
'babacaccaaabaaaaaaaccaaaccaaccabcbbbabccbbabababccaabcccacccaaabaccbccccbaacbcaacbcaaaaaaabacbcbbbcc',
'bcbabbaccacbacaacbbaccbcbccbaaaabbbcaccaacaccbabcbabccacbaabbaaaabbbcbbbbbaababacacbcaabbcbcbcabbaba',
'ifailuhkqqhucpoltgtyovarjsnrbfpvmupwjjjfiwwhrlkpekxxnebfrwibylcvkfealgonjkzwlyfhhkefuvgndgdnbelgruel',
'gffryqktmwocejbxfidpjfgrrkpowoxwggxaknmltjcpazgtnakcfcogzatyskqjyorcftwxjrtgayvllutrjxpbzggjxbmxpnde',
'mqmtjwxaaaxklheghvqcyhaaegtlyntxmoluqlzvuzgkwhkkfpwarkckansgabfclzgnumdrojexnrdunivxqjzfbzsodycnsnmw',
'ofeqjnqnxwidhbuxxhfwargwkikjqwyghpsygjxyrarcoacwnhxyqlrviikfuiuotifznqmzpjrxycnqktkryutpqvbgbgthfges',
'zjekimenscyiamnwlpxytkndjsygifmqlqibxxqlauxamfviftquntvkwppxrzuncyenacfivtigvfsadtlytzymuwvpntngkyhw']

strs.size.times do |t|
  str = strs[t]
  
  char_counts = Array.new(26, 0)
  substr_map = [Array.new(26, 0)]
  str.split('').each_with_index do |s, i|
    int = s.downcase.ord - 97
    char_counts[int] += 1
    substr_map << char_counts.dup
  end
  
  substr_counts = Hash.new{|h, k|h[k]=0}
  str.size.times do |i|
    start_index = 1
    end_index = i + 1
    while start_index <= end_index
  	  comp = substr_map[end_index].each_with_index.map{|c, i|c-substr_map[start_index-1][i]}
  	  substr_counts[comp] += 1
      start_index+=1
    end
  end

  n = 0
  fac = Proc.new{|n|n>0 ? [*1..n].reduce(:*) : 1}
  substr_counts.values.each do |count|
    if count > 1
  	  comb = fac.call(count)/(fac.call(2)*fac.call(count-2))
  	  n += comb
    end
  end
  print n.to_s+"\n"
end
