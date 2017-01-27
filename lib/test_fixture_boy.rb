require "test_fixture_boy/version"
require "test_fixture_boy/record_scanner"
require "test_fixture_boy/printer"
require "test_fixture_boy/talents"

module TestFixtureBoy
  # Your code goes here...
  # No I will not put my code here. The name is too long.
end

# TFBoy is a utility to copy ActiveRecords from you data base and print out a
# Fixture file if you want.
#
# The current supported output file formats are:
# - yaml
#
module TFBoy

  def self.scanner
    puts "scanner"
    @scanner ||= RecordScanner.new
  end

  def self.scan(clear_cache = false)
    scanner.scan(clear_cache) { yield }
  end

  def self.select(attrs)
    scanner.select(attrs)
  end

  def self.except(attrs)
    scanner.except(attrs)
  end

  def self.print(format)
    # Grab all the copied data from scanner
    copy_data =
      case format
      when :yaml
        scanner.print_yaml
      end
    copy_data[:format] = format
    printer = Printer.new copy_data
    printer.print
  end

  def self.show_time
    TestFixtureBoy::Talents.introduce
  end
end
