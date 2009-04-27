require 'rubygems'
gem 'templater', '>= 0.5.0'
require 'templater'

module SousChef
  VERSION = '0.0.1'

  autoload :ApplicationTask,  File.join(File.dirname(__FILE__), 'sous-chef', 'application_task')
  autoload :NodeTask,         File.join(File.dirname(__FILE__), 'sous-chef', 'node_task')
end

path = File.join(File.dirname(__FILE__))

require File.join(path, 'sous-chef', 'generator')
require File.join(path, 'generators', 'application')
require File.join(path, 'generators', 'cookbook')
require File.join(path, 'generators', 'node')
require File.join(path, 'generators', 'file')
require File.join(path, 'generators', 'template')