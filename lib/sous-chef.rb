require 'rubygems'
gem 'templater', '>= 0.5.0'
require 'templater'

path = File.join(File.dirname(__FILE__))

require File.join(path, 'sous-chef', 'generator')
require File.join(path, 'generators', 'application')