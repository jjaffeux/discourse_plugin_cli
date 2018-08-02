require 'fileutils'

module DiscoursePluginCli
  class Blueprint
    attr_reader :blueprint
    attr_reader :name
    attr_reader :author
    attr_reader :dest
    attr_reader :options

    def initialize(name, author, options = {})
      @name = name
      @author = author
      @options = options
      @blueprint = File.join(DiscoursePluginCli.gem_path, "blueprints", "plugin", ".")
      @dest = File.join(Dir.getwd, @name)

      if File.exist?(@dest)
        abort("You already have content at #{@dest}, remove it or change directory before proceeding.")
      end
    end

    def run
      FileUtils.cp_r(@blueprint, self.dest)

      replace_variables_in_files
      rename_template_files
    end

    def replace_variables_in_files
      files = Dir[File.join(self.dest, '**', '*')].select { |f| !File.directory? f }

      files.each do |file_name|
        text = File.read(file_name)

        text.gsub!("${PLUGIN_NAME}", @name)
        text.gsub!("${DASHERIZED_PLUGIN_NAME}", @name.dasherize)
        text.gsub!("${CLASSIFIED_PLUGIN_NAME}", @name.tableize.classify)
        text.gsub!("${AUTHOR}", @author)

        if self.options[:stylesheet]
          text.gsub!(/\${IF_STYLESHEET}(.*?)\${END_IF}/m, '\1'.strip)
        else
          text.gsub!(/\${IF_STYLESHEET}.*?\${END_IF}/m, '')
        end

        if self.options[:job]
          text.gsub!(/\${IF_JOB}.*?\${END_IF}/m, '\1'.strip)
        else
          text.gsub!(/\${IF_JOB}.*?\${END_IF}/m, '')
        end

        File.open(file_name, "w") { |file| file.puts text }
      end
    end

    def rename_template_files
      Dir.chdir(self.dest) do
        FileUtils.mv(
          "assets/javascripts/initializers/plugin-name.js.es6",
          "assets/javascripts/initializers/#{@name.dasherize}.js.es6"
        )

        if self.options[:stylesheet]
          FileUtils.mv(
            "assets/stylesheets/common/plugin-name.scss",
            "assets/stylesheets/common/#{@name.dasherize}.scss"
          )
        else
          FileUtils.rm_rf("assets/stylesheets")
        end

        if self.options[:job]
          FileUtils.mv(
            "jobs/scheduled/plugin_name.rb",
            "jobs/scheduled/check_#{@name.underscore}.rb"
          )
        else
          FileUtils.rm_rf("jobs")
        end
      end
    end
  end
end
