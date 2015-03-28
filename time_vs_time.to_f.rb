require 'benchmark/ips'

next_time = Time.now + 1.0
next_time_f = Time.now.to_f + 1.0
Benchmark.ips do |x|
  x.report("time < float") {  next_time < next_time_f }
  x.report("time.to_f < float") {  next_time_f < next_time_f }
  x.report("time + 1.0") {  next_time + 1.0 }
  x.report("time.to_f + 1.0") {  next_time_f + 1.0 }
end

# Calculating -------------------------------------
#                 time     56966 i/100ms
#            time.to_f     56342 i/100ms
# -------------------------------------------------
#                 time  1170704.1 (±4.7%) i/s -    5867498 in   5.023411s
#            time.to_f  1160727.7 (±3.7%) i/s -    5803226 in   5.006763s
