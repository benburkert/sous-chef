require 'rubygems'
gem 'templater', '>= 0.5.0'
require 'templater'

module SousChef
  VERSION = '0.0.1'
end

path = File.join(File.dirname(__FILE__))

require File.join(path, 'sous-chef', 'generator')
require File.join(path, 'generators', 'application')
require File.join(path, 'generators', 'node')