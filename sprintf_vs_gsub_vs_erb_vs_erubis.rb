require 'benchmark/ips'
require 'erb'
require 'erubis' # gem install erubis

text = "a" * 2500
text_sprintf = text + "%s" + text
text_gsub    = text + "{{foo}}" + text
text_erb     = text = "<%= foo %>" + text
foo = "foo"
erb = ERB.new(text_erb)
erubis = Erubis::Eruby.new(text_erb)

Benchmark.ips do |x|
  x.report("sprintf") { sprintf(text_sprintf, "foo") }
  x.report("gsub")    { text_gsub.gsub('{{foo}}', "foo") }
  x.report("erb")     { erb.result(binding) }
  x.report("erubis")  { erubis.result(binding) }
end

# Calculating -------------------------------------
#              sprintf      9115 i/100ms
#                 gsub      8791 i/100ms
#                  erb      1353 i/100ms
#               erubis      1534 i/100ms
# -------------------------------------------------
#              sprintf   102988.3 (±5.1%) i/s -     519555 in   5.059208s
#                 gsub    97181.6 (±9.6%) i/s -     483505 in   5.027591s
#                  erb    14760.8 (±4.7%) i/s -      74415 in   5.053671s
#               erubis    15690.2 (±7.1%) i/s -      78234 in   5.014597s
