require 'benchmark/ips'

a500 = "a"*500
text_sprintf = "#{a500}%s#{a500}%s"
text = "#{a500}{{foo}}#{a500}{{bar}}"
hash = { '{{foo}}' => 'foo', '{{bar}}' => 'bar' }

def index_replace(template, replace = {})
  offset = 0
  template = template.dup
  replace.each do |key, val|
    index = template.index(key, offset)
    offset = index + key.size
    template[index...offset] = val
  end
  template
end

Benchmark.ips do |x|
  x.report("sprintf")        { sprintf(text_sprintf, 'foo', 'bar') }
  x.report("gsub twice")     { text.gsub('{{foo}}', "foo").gsub!('{{bar}}', 'bar') }
  x.report("gsub hash")      { text.gsub(/{{foo}}|{{bar}}/, hash) }
  x.report("sub twice")      { text.sub('{{foo}}', "foo").sub!('{{bar}}', 'bar') }
  # x.report("sub hash")       { text.sub(/{{foo}}|{{bar}}/, hash) } # this does not change {{bar}}
  x.report("index")          { index_replace(text, hash) }
  x.report("string")         { "#{a500}foo#{a500}bar" }
end

# Calculating -------------------------------------
#              sprintf     20803 i/100ms
#           gsub twice      3573 i/100ms
#            gsub hash     11777 i/100ms
#            sub twice      4323 i/100ms
#                index     12566 i/100ms
# -------------------------------------------------
#              sprintf   321447.0 (±4.4%) i/s -    1622634 in   5.058134s
#           gsub twice    36910.6 (±10.0%) i/s -     182223 in   5.016063s
#            gsub hash   154477.0 (±7.7%) i/s -     765505 in   5.009511s
#            sub twice    49643.1 (±3.2%) i/s -     250734 in   5.055752s
#                index   167764.3 (±1.5%) i/s -     841922 in   5.019646s
