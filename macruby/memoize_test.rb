require 'rubygems'
require 'memoize'
require 'benchmark'
include Memoize

def fib(n)
  return n if n < 2
  fib(n-1) + fib(n-2)
end

def non_disk_mem_fib(n)
  num ||= (n-1)
  fib(num) + fib(n-2)
end
Benchmark.bm(15) do |b|
  b.report("Regular fib:") { fib(35) }
  b.report("Memoized fib:") { memoize(:fib); fib(35)}
  b.report("Non-Disk Memoized fib:") { non_disk_mem_fib(35) }
end
