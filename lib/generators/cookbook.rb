module SousChef
  module Generators
    class CookbookGenerator < CookbookBasedGenerator

      desc <<-DESC
      Generates a new cookbook.
      DESC

      first_argument :cookbook, :required => true, :desc => "Cookbook Name"

      option :recipe, :default => :default, :desc => "Recipe Name"

      option :file, :default => nil, :desc => "File Name(s)"

      file :attribute do |file|
        file.source = File.join('cookbooks', 'default', 'attributes', '%recipe_name%.rb')
        file.destination = File.join('cookbooks', cookbook_name, 'attributes', "#{recipe_name}.rb")
      end

      file :recipe do |file|
        file.source = File.join('cookbooks', 'default', 'recipes', '%recipe_name%.rb')
        file.destination = File.join('cookbooks', cookbook_name, 'recipes', "#{recipe_name}.rb")
      end

      invoke :file do |generator|
        generator.new(destination_root, options, file.to_s) unless file.nil?
      end
    end

    add :cookbook, CookbookGenerator
  end
end