module SousChef
  module Generators
    class NodeGenerator < Generator

      desc <<-DESC
      The name of the new node.
      DESC

      first_argument :node, :required => true, :desc => "Node Name"

      desc <<-DESC
      The Target plateform the application for deployment.
      DESC

      option :platform, :default => :none, :desc => "Target Platform"

      desc <<-DESC
      The environment of the node. e.g. (production, staging, development).
      DESC

      option :environment, :default => :production, :desc => "Deployment Environment"

      template :default_attributes do |template|
        template.source = File.join('nodes', 'default', 'attributes', '%node%_node.rb.erb')
        template.destination = File.join('nodes', node, 'recipes', node, 'attributes', "#{node}_node.rb")
      end

      file :default_recipe do |file|
        file.source = File.join('nodes', 'default', 'recipes', 'default.rb')
        file.destination = File.join('nodes', node, 'recipes', node, 'recipes', 'default.rb')
      end

      directory :ec2_attributes, :platform => :ec2 do |directory|
        directory.source = File.join('nodes', 'ec2', 'attributes')
        directory.destination = File.join('nodes', node, 'recipes', 'system', 'attributes')
      end
    end

    add :node, NodeGenerator
  end
end