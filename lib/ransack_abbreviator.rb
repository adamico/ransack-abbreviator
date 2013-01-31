require "ostruct"
require "yaml"
require 'ransack_abbreviator/configuration'

module RansackAbbreviator
  extend Configuration
  
  class DuplicateColumnAbbreviation < StandardError; end;
end

RansackAbbreviator.configure do |config|
  parsed_config = OpenStruct.new((YAML.load_file(config.config_dir.join("ransack_abbreviator.yml")) rescue {}))
  ransack_abbreviations = parsed_config.ransack_abbreviations
  config.column_abbreviations = ransack_abbreviations["columns"] if ransack_abbreviations["columns"]
  config.association_abbreviations = ransack_abbreviations["associations"] if ransack_abbreviations["associations"]
end

require "ransack_abbreviator/context"
require 'ransack_abbreviator/adapters/active_record'
require "ransack_abbreviator/view_helpers"