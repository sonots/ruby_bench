require 'benchmark/ips'

klass = self.class
Benchmark.ips do |x|
  x.report("self.class") {  self.class }
  x.report("klass") {  klass }
end
# Calculating -------------------------------------
#           self.class     72899 i/100ms
#                klass     75586 i/100ms
# -------------------------------------------------
#           self.class  4502280.0 (±5.3%) i/s -   22452892 in   5.001999s
#                klass  5501155.8 (±3.4%) i/s -   27513304 in   5.007478s
#
# storing to local variable won!
