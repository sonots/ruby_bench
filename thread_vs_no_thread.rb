
def elapsed_time(title, &block)
  start = Time.now
  yield
  puts "#{title}\t#{(Time.now - start).to_f}"
end

def run
  n = 100000000
  i = 0
  while i < n
    i += 1
  end
end

elapsed_time(:no_thread) do
  run
end

# Does GVL affect anything? => seems no
threads = []
(1..10).each do |j|
  threads << Thread.new do
    while sleep 0.1
    end
  end
end
elapsed_time(:thread) do
  run
end
threads.each {|t| t.terminate }

#result
#no_thread 3.062401204
#thread    2.978104308

