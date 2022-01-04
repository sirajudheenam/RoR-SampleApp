# IRB Config: ~/.irbrc
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT_MODE] = false

```ruby
IRB:
>> nil.to_s.empty?
true

>> nil.nil?
true

>> !!false
false

>> !!nil
false

>> false
false


"foo bar     baz".split
["foo", "bar", "baz"]
"foo bar    \t baz".split
["foo", "bar", "baz"]
"fooxbarxbaz".split('x')
["foo", "bar", "baz"]

a = [23, 44, 33]
>> a[2]
=> 33
>> a.first
=> 23
>> a.last
=> 23
# equal to a.last
>> a[-1]
=> 33
>> a.last == a[-1]
=> true

x = a.length
3
x == 3
true
x == 1
false

a.empty?
false
[].empty?
true
>> a.reverse
=> [33, 44, 23]
>> a.sort
=> [23, 33, 44]
>> a.include?(44)
=> true

>> a.shuffle
=> [44, 33, 23]
>> a
=> [23, 44, 33]
>> a.sort
=> [23, 33, 44]
# sort doesn't mutate the array
>> a
=> [23, 44, 33]
>> a.sort!
=> [23, 33, 44]
# sort! mutates the array
>> a
=> [23, 33, 44]
>>

>> a.push(5)
=> [23, 33, 44, 5]
>> a << 8
=> [23, 33, 44, 5, 8]
>> a << "foo" << "bar"
=> [23, 33, 44, 5, 8, "foo", "bar"]


>> a.join
=> "23334458foobar"
>> a.join(', ')
=> "23, 33, 44, 5, 8, foo, bar"


>> 0..9.to_a
Traceback (most recent call last):
        4: from /Users/i072278/.rvm/rubies/ruby-2.7.2/bin/irb:23:in `<main>'
        3: from /Users/i072278/.rvm/rubies/ruby-2.7.2/bin/irb:23:in `load'
        2: from /Users/i072278/.rvm/rubies/ruby-2.7.2/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):22
NoMethodError (undefined method `to_a' for 9:Integer)
Did you mean?  to_c
               to_r
               to_f
               to_i
               to_s

>> (0..9).to_a
=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]


>> a = %w[aadu maadu koli kunju]
=> ["aadu", "maadu", "koli", "kunju"]
>> a = %w{aadu maadu koli kunju}
=> ["aadu", "maadu", "koli", "kunju"]
>> a = %w(aadu maadu koli kunju)
=> ["aadu", "maadu", "koli", "kunju"]

>> a[0..2]
=> ["aadu", "maadu", "koli"]

>> a = (0..9).to_a
=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

>> a[2..(a.length - 1)]
=> [2, 3, 4, 5, 6, 7, 8, 9]

>> a[2..-1]
=> [2, 3, 4, 5, 6, 7, 8, 9]

>> b = ('a'..'f').to_a
=> ["a", "b", "c", "d", "e", "f"]

# Blocks:

(1..5).to_a

>> (1..5).each { |i| puts 2 * i }
2
4
6
8
10
=> 1..5

?> (1..5).each do |i|
?>   puts 2 * i
>> end

2
4
6
8
10
=> 1..5
?> (1..5).each do |i|
?>   puts 3 * i
?>   puts "--"
>> end
3
--
6
--
9
--
12
--
15
--
=> 1..5

>> (1..5).each { |i| puts 3 * i; puts "---" }

3
---
6
---
9
---
12
---
15
---
=> 1..5

>> 3.times { puts "Duck at Kanniyakurichi" }
Duck at Kanniyakurichi
Duck at Kanniyakurichi
Duck at Kanniyakurichi


>> squares = (1..4).each { |i| puts i**2 }
1
4
9
16
=> 1..4
>> squares = []
=> []
>> (1..4).each { |i| squares << i**2 }
=> 1..4
>> squares
=> [1, 4, 9, 16]

# map method is far efficient
>> squares = (1..4).map { |i| i**2 }
=> [1, 4, 9, 16]



>> %w[a b c ].map { |i| i.upcase }
=> ["A", "B", "C"]
>> %w[D E F].map { |i| i.downcase }
=> ["d", "e", "f"]

>> %w{G H I}.map(&:downcase)
=> ["g", "h", "i"]
# &:downcase is part of `rails` and it is incorporated in to `ruby`.


# HASHES in Ruby
user = {}
user["first_name"] = "Sam"
user["last_name"] = "Miller"

>> user = {}
=> {}
>> user["first_name"] = "Sam"
=> "Sam"
>> user["last_name"] = "Miller"
=> "Miller"
>> user
=> {"first_name"=>"Sam", "last_name"=>"Miller"}
user = { "first_name"=>"Sam", "last_name"=>"Miller" }

# Symbols:

user = { :first_name => "Sam", :last_name => "Miller" }


>> h1 = { first_name: "Sam", last_name: "Miller" }
=> {:first_name=>"Sam", :last_name=>"Miller"}
>> h2 = { :first_name => "Sam", :last_name => "Miller" }
=> {:first_name=>"Sam", :last_name=>"Miller"}
>> h1 == h2
=> true


>> params = {}
=> {}
>> params[:person] = { name: "Sam Miller", email: "sammiller@example.com" }
=> {:name=>"Sam Miller", :email=>"sammiller@example.com"}
>> params[:person]
=> {:name=>"Sam Miller", :email=>"sammiller@example.com"}
>> params[:person][:name]
=> "Sam Miller"
>> params[:person][:email]
=> "sammiller@example.com"

>> flash = {}
=> {}
>> flash = { success: "It rocks", danger: "It failed" }
=> {:success=>"It rocks", :danger=>"It failed"}

?> flash.each do |key, value|
?>   puts"#{key} has a value of #{value}"
>> end
success has a value of It rocks
danger has a value of It failed
=> {:success=>"It rocks", :danger=>"It failed"}

?> flash.each do |key, value|
?>   puts"#{key.inspect} has a value of #{value.inspect}"
>> end
:success has a value of "It rocks"
:danger has a value of "It failed"
=> {:success=>"It rocks", :danger=>"It failed"}


>> puts flash
{:success=>"It rocks", :danger=>"It failed"}
=> nil
>> p flash
{:success=>"It rocks", :danger=>"It failed"}
=> {:success=>"It rocks", :danger=>"It failed"}
>> puts flash.keys
success
danger
=> nil
>> p flash.keys
[:success, :danger]
=> [:success, :danger]


>> flash.keys
=> [:success, :danger]
>> flash.values
=> ["It rocks", "It failed"]

# Classes objects methods

?> class Word
?>   def palindrome?(str)
?>     str == str.reverse
?>   end
>> end
=> :palindrome?
>> w = Word.new
=> #<Word:0x00007fb945afe3c0>
>> w.palindrome?("Mannargudi")
=> false
>> w.palindrome?("dad")
=> true

# Inherited class

?> class Word < String
?>   def palindrome?
?>     self == self.reverse
?>   end
>> end
=> :palindrome?
>> w = Word.new("Yahoo")
=> "Yahoo"
>> w.palindrome?
=> false
>> k = Word.new("foof")
=> "foof"
>> k.palindrome?
=> true

# Add function to the existing build-in class String

class String
  def palindrome?
    self == reverse
  end
end

?> class String
?>   def palindrome?
?>     self == reverse
?>   end
>> end
=> :palindrome?
>> "madam".palindrome?
=> true
>> "Telegram".palindrome?
=> false


>> require 'rails'
=> true
>> "".blank?
=> true
>> "     ".blank?
=> true
>> nil.blank?
=> true
