require 'benchmark'
n = 1000000

foo = nil
Benchmark.bm(7, ">throw", ">raise:", ">if:") do |x|
  a = x.report("throw") { n.times {
    catch(:foo) do
      while true
        while true
          throw :foo if foo.nil?
        end
      end
    end
  }}
  b = x.report("raise") { n.times {
    begin
      while true
        while true
          raise :foo if foo.nil?
        end
      end
    rescue
    end
  }}
  c = x.report("if") { n.times {
    is_break = false
    while true
      while true
        is_break = true and break if foo.nil?
      end
      break if is_break
    end
  }}
end
#              user     system      total        real
#throw     0.610000   0.000000   0.610000 (  0.609155)
#raise     4.910000   0.050000   4.960000 (  5.118787)
#if        0.180000   0.010000   0.190000 (  0.182652)
