#!/usr/bin/env ruby
require 'rexml/document' # rexml is awful. How about using nokogiri?

def convert(elem)
  p elem
  elem.each_element do |elem|
    convert(elem)
  end
end

if $0 == __FILE__
  doc = REXML::Document.new(File.read('demo1.tgs'))
  puts doc
  convert(doc.root)
end
