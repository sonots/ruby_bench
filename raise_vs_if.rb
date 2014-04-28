require 'benchmark/ips'

foo = nil
Benchmark.ips do |x|
  x.report("raise") {  begin; foo.foo; rescue; end }
  x.report("if") {  if foo.nil?; end }
end
#Calculating -------------------------------------
#               raise     14852 i/100ms
#                  if     72725 i/100ms
#-------------------------------------------------
#               raise   187487.1 (±6.1%) i/s -     935676 in   5.013734s
#                  if  4547458.2 (±5.2%) i/s -   22690200 in   5.006327s
