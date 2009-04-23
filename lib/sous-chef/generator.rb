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

    class CookbookBasedGenerator < Generator
      def cookbook_name
        cookbook.to_s.split('::')[0]
      end

      def recipe_name
        if recipe == :default && cookbook.to_s =~ /^\w+::\w+$/
          cookbook.to_s.split('::')[1]
        else
          recipe.to_s
        end
      end
    end
  end
end