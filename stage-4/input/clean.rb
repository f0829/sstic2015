#!/usr/bin/env ruby

require 'rkelly'
require 'pp'

parser = RKelly::Parser.new
ast    = parser.parse(File.read(ARGV.shift))

#ast = parser.parse("$$$$$ = 'chrome'; console.log($$$$$ + 'toto');");

vars = {}
ast.each do |node|
  if node.kind_of? RKelly::Nodes::OpEqualNode
    if node.left.kind_of? RKelly::Nodes::ResolveNode and
      node.value.kind_of? RKelly::Nodes::StringNode
      vars[node.left.value] = node.value
    end
  end
end

ast.each do |node|
  if node.kind_of? RKelly::Nodes::ResolveNode
    p node.parent
  end
end

pp vars
