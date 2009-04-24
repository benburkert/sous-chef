require 'rake'
require 'rake/tasklib'

module SousChef
  class ApplicationTask < ::Rake::TaskLib
    def initialize(dir)
      @nodes = Dir[File.join(dir, 'nodes', '*')].map {|f| File.basename(f).gsub(/\.rb$/, '')}

      @nodes.each {|n| SousChef::NodeTask.new(n, dir)}
    end
  end
end