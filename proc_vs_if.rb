require 'benchmark/ips'
require 'json'

class OutFileFormatter
  def initialize
    @delimiter = "\t"
    @output_time = true
    @output_tag = true
  end

  def format(tag, time, record)
    header = ''
    header << "#{Time.at(time).to_s}#{@delimiter}" if @output_time
    header << "#{tag}#{@delimiter}" if @output_tag
    "#{header}#{record.to_json}\n"
  end
end

class OutFileFormatter2
  def initialize
    @delimiter = "\t"
    @output_time = true
    @output_tag = true
    @header_proc =
      if @output_time and @output_tag
        Proc.new {|time, tag| "#{Time.at(time).to_s}#{@delimiter}#{tag}#{@delimiter}" }
      elsif @output_time
        Proc.new {|time, tag| "#{Time.at(time).to_s}#{@delimiter}" }
      elsif @output_tag
        Proc.new {|time, tag| "#{tag}#{@delimiter}" }
      else
        Proc.new {|time, tag| "" }
      end
  end

  def format(tag, time, record)
    header = @header_proc.call(time, tag)
    "#{header}#{record.to_json}\n"
  end
end

@formatter = OutFileFormatter.new
@formatter2 = OutFileFormatter2.new

Benchmark.ips do |x|
  x.report("if") { @formatter.format('a', 123456, {"message" => "fooo"}) }
  x.report("proc") { @formatter2.format('a', 123456, {"message" => "fooo"}) }
end
#Proc did not boost, holy cow...
#Calculating -------------------------------------
#                  if      5415 i/100ms
#                proc      5568 i/100ms
#-------------------------------------------------
#                  if    64259.6 (±5.8%) i/s -     324900 in   5.074129s
#                proc    64301.6 (±11.1%) i/s -     317376 in   5.019855s
#
