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

      empty_directory :config, 'config'
      empty_directory :nodes, 'nodes'
      empty_directory :cookbooks, 'cookbooks'

      invoke :node do |generator|
        generator.new(destination_root, options, node.to_s) unless node == :none
      end

      file :config, :platform => :none do |file|
        file.source = File.join('files', 'blank')
        file.destination = File.join('config', 'sous-chef.yml')
      end

      file :config, :platform => :solo do |file|
        if File.exists? File.expand_path("~/.ey-cloud.yml")
          file.source = File.expand_path("~/.ey-cloud.yml")
        else
          file.source = File.join('files', 'blank')
        end
        file.destination = File.join('config', 'sous-chef.yml')
      end

      file :Rakefile do |file|
        file.source = File.join('application', 'Rakefile')
        file.destination = File.join('Rakefile')
      end
    end

    add :app, ApplicationGenerator
  end
end