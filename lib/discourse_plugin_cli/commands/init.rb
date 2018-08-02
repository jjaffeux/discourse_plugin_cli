module DiscoursePluginCli
  class Init < Runner
    self.summary = "Helps create a new plugin."
    self.command = "init"
    self.arguments = [
      CLAide::Argument.new("NAME", true),
      CLAide::Argument.new("AUTHOR", true),
    ]

    def initialize(argv)
      @stylesheet = argv.flag?("stylesheet", true)
      @job = argv.flag?("job", true)
      @name = argv.shift_argument
      @author = argv.shift_argument

      super
    end

    def self.options
      [
        ["--stylesheet", "Stylesheet support (default: true). Use --no-stylesheet to disable."],
        ["--job", "Sidekiq job support (default: true). Use --no-job to disable."]
      ].concat(super)
    end

    def validate!
      super

      if @name.nil? || @name.empty?
        help! "A name for the plugin is required."
      end

      if @author.nil? || @author.empty?
        help! "An author for the plugin is required. Use quotes if spaces."
      end

      help! "The plugin name cannot contain spaces." if @name =~ /\s/
    end

    def run
      DiscoursePluginCli::Blueprint.new(@name, @author, {
          stylesheet: @stylesheet,
          job: @job,
      }).run
    end
  end
end
