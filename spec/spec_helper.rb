require 'rack/test'
require 'rspec'

require File.expand_path '../../sinatra_tiny_url_app.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

# For RSpec 2.x
RSpec.configure do |config|
  config.include RSpecMixin
  config.expect_with(:rspec) { |c| c.syntax = :should }
end

