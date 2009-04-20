module SousChef
  module Generators
    extend Templater::Manifold

    desc <<-DESC
      Generate cookbooks, nodes, and recipes for your chef scripts.
    DESC

    class Generator < ::Templater::Generator
      def destination_root
        File.join(@destination_root, name)
      end
    end
  end
end