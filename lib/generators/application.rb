module SousChef
  module Generators
    class ApplicationGenerator < Generator

      desc <<-DESC
      Generates a new chef cookbook with recipes and nodes.
      DESC

      first_argument :name, :required => true, :desc => "Application name"
    end
  end
end