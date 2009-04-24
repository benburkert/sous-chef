require 'rake'
require 'rake/tasklib'
require 'ey'

module SousChef
  class NodeTask < ::Rake::TaskLib
    def initialize(name, dir)
      @name, @dir = name, dir
      @path = "#{dir}/nodes/#{name}"

      @cookbook_dir     = "cookbooks"
      @node_dir         = "nodes/#{@name}/cookbooks"
      @base_dir         = "pkg/#{name}"
      @pkg_dir          = "pkg/#{@name}/cookbooks"
      @git_dir          = "pkg/#{@name}/.git"

      yield self if block_given?

      define
    end

    def define
      namespace @name do

        task :copy_cookbooks  => define_copy_for(@cookbook_dir, @pkg_dir)
        task :copy_nodes      => define_copy_for(@node_dir, @pkg_dir)

        task :copy => [:copy_cookbooks, :copy_nodes]

        desc "Package the #{@name} cookbook."
        task :package => [:copy]

        desc "test the #{@name} cookbook."
        task :test => :package do
          puts "** Testing your cookbooks for syntax errors"
          Dir[ File.join(@pkg_dir, "**", "*.rb") ].each do |recipe|
            sh %{ruby -c #{recipe}} do |ok, res|
              if ! ok
                raise "Syntax error in #{recipe}"
              end
            end
          end
        end

        file @git_dir do
          in_dir @base_dir do
            sh 'git init'
          end
        end

        task :commit => @git_dir do
          in_dir @base_dir do
            sh 'git add *'
            sh "git commit -m \"Auto Commit: #{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}\"" if system("git status")
          end
        end

        desc "Deploy the #{@name} cookbook."
        task :deploy => [:package, :test, :commit] do
          in_dir @base_dir do
            config = YAML::load(IO.read(File.expand_path('config/sous-chef.yml')))
            EY::ChefRecipes.new(config.merge(:command => :deploy, :env => @name, :type => 'recipes')).deploy
          end
        end
      end
    end

    def define_copy_for(source, destination)
      in_dir(source) { Dir['**/*'] }.reject {|path| File.directory?(File.join(source, path)) }.map { |f|
        source_file, dest_file = File.join(source, f), File.join(destination, f)
        directory(dest_dir = File.dirname(dest_file))
        file dest_file => [dest_dir, source_file] do
          cp source_file, dest_file
        end
        dest_file
      }
    end

    def in_dir dir
      pwd = Dir.pwd
      begin
        cd dir
        yield if block_given?
      ensure
        cd pwd
      end
    end
  end
end