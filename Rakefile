# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

desc 'default checks'
task default: [:lint]

desc 'Testing tasks'
task test: %w[test:unit]

# Rubocop
desc 'Run Rubocop lint checks'
task :rubocop do
  RuboCop::RakeTask.new
end

# lint the project
desc 'Run robocop linter'
task lint: [:rubocop]

# Automatically generate a changelog for this project. Only loaded if
# the necessary gem is installed.
# use `rake changelog to=1.2.0`
begin
  v = ENV['to']
  require 'github_changelog_generator/task'
  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    config.future_release = v
  end
rescue LoadError
  puts '>>>>> GitHub Changelog Generator not loaded, omitting tasks'
end

namespace :test do
  # Minitest
  Rake::TestTask.new(:unit) do |t|
    t.libs << 'test/unit'
    t.libs << 'libraries'
    t.verbose = true
    t.warning = false
    t.test_files = Rake::FileList['test/unit/**/*_test.rb']
  end
end
