require "active_support/core_ext/string/inflections"
require "discourse_plugin_cli/version"
require "discourse_plugin_cli/core/blueprint"
require "discourse_plugin_cli/commands/runner"

module DiscoursePluginCli
  GEM_NAME = "discourse_plugin_cli".freeze

  def self.gem_path
    if Gem::Specification.find_all_by_name(GEM_NAME).empty?
      raise "Couldn't find gem directory for '#{GEM_NAME}'"
    end
    return Gem::Specification.find_by_name(GEM_NAME).gem_dir
  end
end
