module SousChef
  module Generators
    class ApplicationGenerator < Generator

      def destination_root
        File.join(@destination_root, name)
      end

      desc <<-DESC
      Generates a new chef cookbook with recipes and nodes.
      DESC

      first_argument :name, :required => true, :desc => "Application Name"

      desc <<-DESC
      The Target plateform the application for deployment.
      DESC

      option :platform, :default => :none, :desc => "Target Platform"

      desc <<-DESC
      An initial deployment node.
      DESC

      option :node, :default => :none, :desc => "Initial Node"

      empty_directory :nodes, 'nodes'
      empty_directory :recipes, 'recipes'
    end

    add :app, ApplicationGenerator
  end
end