#!/usr/bin/env ruby

require 'rexml/document'

#doc = REXML::Document.new(File.read('example.tgs'))
doc = REXML::Document.new(File.read('demo2.tgs'))
p doc.root, doc.root.class
