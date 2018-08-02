# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'discourse_plugin_cli/version'

Gem::Specification.new do |s|
  s.name          = 'discourse_plugin_cli'
  s.version       = DiscoursePluginCli::VERSION
  s.licenses      = ['MIT']
  s.summary       = 'The Discourse Plugin CLI'
  s.description   = 'Create and manage your discourse plugin'
  s.authors       = ['Joffrey Jaffeux']
  s.email         = 'j.jaffeux@gmail.com'
  s.files         = Dir["lib/**/*", "blueprints/**/*"] + %w(bin/dcli)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.homepage      = 'https://rubygems.org/gems/example'
  s.metadata      = { 'source_code_uri' => 'https://github.com/example/example' }
  s.executables   << 'dcli'
  s.bindir        = 'bin'

  s.add_runtime_dependency "claide", "~> 1.0"
  s.add_runtime_dependency "activesupport"
end
