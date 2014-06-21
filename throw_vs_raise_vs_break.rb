require 'benchmark'
n = 1000000

foo = nil
Benchmark.bm(7, ">throw", ">raise:", ">break:") do |x|
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
  c = x.report("break") { n.times {
    is_break = false
    while true
      while true
        is_break = true and break if foo.nil?
      end
      break if is_break
    end
  }}
end
#raise is stupidly slow. `break if` is the fastest, but throw looks good to use. 
#              user     system      total        real
#throw     0.660000   0.000000   0.660000 (  0.664681)
#raise     4.250000   0.070000   4.320000 (  4.468123)
#break     0.380000   0.000000   0.380000 (  0.393236)
