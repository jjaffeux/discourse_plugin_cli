require 'claide'

module DiscoursePluginCli
  class Runner < CLAide::Command
    require "discourse_plugin_cli/commands/init"

    self.summary = "Run the Discourse Plugin CLI."
    self.command = "discourse_plugin_cli"
    self.version = DiscoursePluginCli::VERSION

    def run
      help!("A COMMAND is required")
    end
  end
end
