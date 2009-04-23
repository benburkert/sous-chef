module SousChef
  module Generators
    class ApplicationGenerator < Generator

      desc <<-DESC
        Generate cookbooks, nodes, and recipes for your chef scripts.
      DESC

      def destination_root
        File.join(@destination_root, name)
      end

      first_argument :name, :required => true, :desc => "Application Name"

      option :platform, :default => :none, :desc => "Target Platform"

      option :node, :default => :none, :desc => "Initial Node"

      empty_directory :nodes, 'nodes'
      empty_directory :cookbooks, 'cookbooks'

      invoke :node do |generator|
        generator.new(destination_root, options, node.to_s) unless node == :none
      end
    end

    add :app, ApplicationGenerator
  end
end