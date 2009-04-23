module SousChef
  module Generators

    class FileGenerator < CookbookBasedGenerator

      desc <<-DESC
      Generate new files for a cookbook recipe.
      DESC

      option :cookbook, :required => true, :desc => "Cookbook Name"

      option :recipe, :default => :default, :desc => "Recipe Name"

      first_argument :filename, :required => true, :desc => "File Name(s)"

      file :file do |file|
        file.source = File.join('files', 'blank')
        file.destination = File.join('cookbooks', cookbook_name, 'files', recipe_name, filename)
      end

      template :recipe do |template|
        template.source = File.join('files', '%recipe_name%.rb.erb')
        template.destination = File.join('cookbooks', cookbook_name, 'recipes', "#{recipe_name}.rb")
      end
    end

    add :file, FileGenerator
  end
end