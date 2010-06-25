#!/usr/bin/env ruby
require 'rexml/document'

class Translator
	def initialize(script)
		@script = script
    @block_level = 0
	end
	
	def self.parse(s)
		doc = REXML::Document.new(s)
		ret = Translator.new(doc.root)
	end

	def translate(elem = @script)
		return unless elem
		  case elem.name
      when /TagoScript/i
        puts "/* TagoScript */"
      when 'include'
        #p elem.methods.sort
        puts "#include <#{elem.attribute('libr')}>"
      when 'int'
        if attr_main = elem.attribute('main') then
          puts "int main(#{attr_main}){" if attr_main
          @block_level += 1
          translate(elem.next_element)
        end
        if attr_targ = elem.attribute('targ') then
          indent = "    " * @block_level
          attr_prop = elem.attribute('prop')
          prop = attr_prop.to_s
          prop = ('null' == prop) ? 0 : prop
          puts indent + "#{attr_targ} = #{prop}"
        end

      when 'if'
      else
        p elem
      end
		elem.each_element do |elem|
      @pre = true
      @post = false
      translate(elem)
      @pre = false
      @post = false
			translate(elem)
      @pre = false
      @post = true
      translate(elem)
		end
	end
	
	def dump(elem = @script)
		p elem
		elem.each_element do |elem|
			dump(elem)
		end
	end
end


if $0 == __FILE__
	xltor = Translator.parse(File.read('demo1.tgs'))
	xltor.translate
end


