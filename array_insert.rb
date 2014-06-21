# -*- coding: utf-8 -*-

require 'benchmark'
num = (ARGV[0] || 10000000).to_i

Benchmark.bm(7) do |x|
  x.report("<<") do
    arr = []
    num.times {|i| arr << i }
  end
  x.report("push") do
    arr = []
    num.times {|i| arr.push(i) }
  end
  x.report("unshift") do
    arr = []
    num.times {|i| arr.unshift(i) }
  end
  x.report("[]") do
    arr = []
    num.times {|i| arr[i] = i }
  end
end
#ruby 2.0.0p247 (2013-06-27 revision 41674) [i686-linux]
#1000000
#              user     system      total        real
#<<        0.190000   0.010000   0.200000 (  0.216118)
#push      0.190000   0.000000   0.190000 (  0.205883)
#unshift   0.210000   0.010000   0.220000 (  0.229883)
#[]        0.150000   0.000000   0.150000 (  0.163583)
#
# << is fast!!
#10000000
#              user     system      total        real
#<<        1.300000   0.030000   1.330000 (  1.392003)
#push      1.660000   0.050000   1.710000 (  1.764898)
#unshift   1.820000   0.040000   1.860000 (  1.932443)
#[]        1.670000   0.030000   1.700000 (  1.752709)
