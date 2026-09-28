# frozen_string_literal: true

require_relative '../../test_helper'

# A resource pack ships to production, so a library file must not require a
# debugger. pry is declared only in the Gemfile's development and test group and
# resolves at runtime purely because inspec-core happens to depend on it.
class NoDebuggerRequiresTest < Minitest::Test
  LIBRARIES_DIR = File.expand_path('../../../libraries', __dir__)
  DEBUGGERS = %w[pry pry-byebug pry-coolline pry-rescue byebug debug debugger].freeze

  def test_no_library_file_requires_a_debugger
    offenders = Dir.glob(File.join(LIBRARIES_DIR, '**', '*.rb')).sort.flat_map do |path|
      File.readlines(path).each_with_index.filter_map do |line, index|
        required = line[/\A\s*require\s+['"]([^'"]+)['"]/, 1]
        next unless DEBUGGERS.include?(required)

        "#{path.delete_prefix("#{LIBRARIES_DIR}/")}:#{index + 1}: #{line.strip}"
      end
    end

    assert_empty(offenders, "Library files must not require a debugger:\n\t- #{offenders.join("\n\t- ")}")
  end
end
