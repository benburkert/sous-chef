module SousChef
  module Generators

    class TemplateGenerator < CookbookBasedGenerator

      desc <<-DESC
      Generate new template for a cookbook recipe.
      DESC

      option :cookbook, :required => true, :desc => "Cookbook Name"

      option :recipe, :default => :default, :desc => "Recipe Name"

      first_argument :template, :required => true, :desc => "Template Name(s)"

      file :template do |file|
        file.source = File.join('templates', 'blank')
        file.destination = File.join('cookbooks', cookbook_name, 'templates', recipe_name, template)
      end

      template :recipe do |template|
        template.source = File.join('templates', '%recipe_name%.rb.erb')
        template.destination = File.join('cookbooks', cookbook_name, 'recipes', "#{recipe_name}.rb")
      end
    end

    add :template, TemplateGenerator
  end
end