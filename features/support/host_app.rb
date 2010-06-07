STDOUT.sync = true

require 'fileutils'

class HostApp
  attr_reader :gem_root, :name, :root, :template, :resource_layout, :options

  def initialize(gem_root, options = {}, &block)
    raise ArgumentError, "'#{gem_root}' is not a directory" unless File.directory?(gem_root)

    @gem_root        = gem_root
    @name            = options[:name] || File.basename(@gem_root)
    @root            = "/tmp/host_app_#{@name}"
    @template        = options[:template] || "#{@gem_root}/test/fixtures/host_app_template.rb"
    @resource_layout = "#{@gem_root}/test/fixtures/host_app_resource_layout.rb"
    @options         = options

    if options[:regenerate]
      regenerate
      generate_resource_layout if File.exists?(@resource_layout)
      require_environment
      in_root { self.instance_exec(&block) } if block_given?
      migrate
    else
      require_environment
    end
  end
  
  def regenerate?
    !options.key?(:regenerate) || !options[:regenerate]
  end

  def in_root(&block)
    Dir.chdir(root) do
      yield
    end
  end

  def run(command, &block)
    in_root do
      system "#{command}"
    end
  end

  def regenerate
    FileUtils.rm_rf(root) if File.exist?(root)
    system "GEM_ROOT='#{gem_root}' rails #{root} -m #{template}"
  end

  def generate_resource_layout
    FileUtils.cp(resource_layout, "#{root}/config/resource_layout.rb")
    run "rails generate resource_layout --generator=ingoweiss:scaffold"
  end

  def migrate
    run "rake db:migrate db:schema:dump db:test:clone_structure"
  end

  def require_environment
    in_root do
      require "#{root}/config/environment"
    end
  end
end