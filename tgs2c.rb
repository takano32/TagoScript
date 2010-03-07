#!/usr/bin/env ruby
require 'rexml/document' # rexml is awful. How about using nokogiri?

doc = REXML::Document.new(File.read('demo1.tgs'))

puts doc
def convert(elem)
  p elem
  elem.each_element do |elem|
    convert(elem)
  end
end

convert(doc.root)

