module SousChef
  module Generators
    extend Templater::Manifold

    desc <<-DESC
      Generate cookbooks, nodes, and recipes for your chef scripts.
    DESC

    class Generator < ::Templater::Generator
      def self.source_root
        File.join(File.dirname(__FILE__), '..', 'generators', 'templates')
      end
    end
  end
end