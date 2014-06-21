require 'benchmark/ips'

def foo
end

Benchmark.ips do |x|
  x.report("call") {  foo }
  x.report("method_defined") {  bar if self.class.method_defined?(:bar) }
end
# call wins a bit
#Calculating -------------------------------------
#                call     65835 i/100ms
#      method_defined     66534 i/100ms
#-------------------------------------------------
#                call  4514967.9 (±7.7%) i/s -   22449735 in   5.009070s
#      method_defined  3045663.2 (±6.0%) i/s -   15169752 in   5.000485s
