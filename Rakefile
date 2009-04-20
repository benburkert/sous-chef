require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require File.join(File.dirname(__FILE__), 'lib', 'sous-chef')

##############################################################################
# Package && release
##############################################################################
PROJECT_URL         = "http://github.com/benburkert/sous-chef"
PROJECT_SUMMARY     = "An assistant for Chef."
PROJECT_DESCRIPTION = PROJECT_SUMMARY
GEM_AUTHOR          = "Ben Burkert"
GEM_EMAIL           = "ben@benburkert.com"
GEM_NAME            = "sous-chef"
GEM_VERSION         = SousChef::VERSION
RELEASE_NAME        = "REL #{GEM_VERSION}"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = GEM_NAME
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = false  #we don't need no stinkin rdoc
  s.summary = PROJECT_SUMMARY
  s.description = PROJECT_DESCRIPTION
  s.author = GEM_AUTHOR
  s.email = GEM_EMAIL
  s.homepage = PROJECT_URL
  s.bindir = "bin"
  s.executables = %w( chef-gen )

  s.add_dependency "templater", ">= 0.5.0"

  s.require_path = 'lib'
  s.files = %w(LICENSE Rakefile) + Dir.glob("{lib,bin}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install the gem"
task :install => :package do
  system("sudo gem install pkg/sous-chef-#{SousChef::VERSION}.gem --no-ri --no-rdoc")
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

