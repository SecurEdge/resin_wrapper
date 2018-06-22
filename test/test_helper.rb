# test/test_helper.rb
require './lib/resinio'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'byebug'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures'
  c.hook_into :webmock
  c.filter_sensitive_data('RESIN_API_KEY') { ENV["RESIN_API_KEY"] }
end
