#!/usr/bin/env ruby
require 'rexml/document'

class Translator
	def initialize(script)
		@script = script
	end
	
	def self.parse(s)
		doc = REXML::Document.new(s)
		ret = Translator.new(doc.root)
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
	xltor.dump
end


