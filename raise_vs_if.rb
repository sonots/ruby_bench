require 'benchmark'
n = 1000000

foo = nil
Benchmark.bm(7, ">raise:", ">if:") do |x|
  a = x.report("raise") {  n.times{ begin; foo.foo; rescue; end } }
  b = x.report("if") {  n.times{ if foo.nil?; end } }
end
#              user     system      total        real
#raise     5.210000   0.010000   5.220000 (  5.302661)
#if        0.120000   0.000000   0.120000 (  0.117799)
