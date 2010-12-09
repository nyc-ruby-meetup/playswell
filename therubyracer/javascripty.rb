require 'v8'

cxt = V8::Context.new
cxt.eval('7 * 6')

cxt['foo'] = "bar"

cxt.eval('foo')
cxt["say"] = lambda {|word, times| word * times}
cxt.eval("say('Hello', 3)")

class MyMath
  def plus(lhs, rhs)
    lhs + rhs
  end
end

cxt['math'] = MyMath.new
cxt.eval("math.plus(20,22)")
  
  
math = MyMath.new
V8::Context.new(:with => math) do |cxt|
  cxt.eval("plus(20,22)") #=> 42
end

#you can do the same thing with Object#eval_js

math.eval_js("plus(20,22)")


File.open("../arrowd.js") do |file|
  cxt.eval(file, "../arrowd.js")
end

cxt.load("../arrowd.js")



class A
  def a
    "a"
  end
end

class B < A
  def b
    "b"
  end
end

V8::Context.new do |cxt|
  cxt['a'] = A.new
  cxt['b'] = B.new
  cxt.eval("a.a") # => 'a'
  cxt.eval("b.b") # => 'b'
  cxt.eval("b.a") # => undef
end