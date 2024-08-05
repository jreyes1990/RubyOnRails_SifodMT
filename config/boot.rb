ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

ENV['NLS_LANG'] ||= 'AMERICAN_AMERICA.WE8ISO8859P1'

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
