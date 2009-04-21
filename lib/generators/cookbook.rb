module SousChef
  module Generators
    class CookbookGenerator < Generator

      def cookbook_name
        cookbook.to_s.split('::')[0]
      end

      def recipe_name
        if recipe == :default && cookbook =~ /^\w+::\w+$/
          cookbook.to_s.split('::')[1]
        else
          recipe
        end
      end

      desc <<-DESC
      The name of the new cookbook.
      DESC

      first_argument :cookbook, :required => true, :desc => "Cookbook Name"

      desc <<-DESC
      The name of the recipe to generate for a cookbook.
      DESC

      option :recipe, :default => :default, :desc => "Recipe Name"

      file :attribute do |file|
        file.source = File.join('cookbooks', 'default', 'attributes', '%recipe_name%.rb')
        file.destination = File.join('cookbooks', cookbook_name, 'attributes', "#{recipe_name}.rb")
      end

      file :recipe do |file|
        file.source = File.join('cookbooks', 'default', 'recipes', '%recipe_name%.rb')
        file.destination = File.join('cookbooks', cookbook_name, 'recipes', "#{recipe_name}.rb")
      end
    end

    add :cookbook, CookbookGenerator
  end
end