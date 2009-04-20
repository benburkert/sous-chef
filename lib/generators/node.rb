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

      template :node_attributes, :platform => :none do |template|
        template.source = File.join('nodes', 'default', 'attributes', '%node%_node.rb.erb')
        template.destination = File.join('nodes', node, 'attributes', "#{node}_node.rb")
      end
    end

    add :node, NodeGenerator
  end
end