require 'sinatra'
require 'redis'
require 'haml'
require './sinatra_tiny_url_helpers'

class SinatraTinyUrl < Sinatra::Base
  helpers SinatraTinyUrlHelpers

  get '/' do
    haml :index
  end

  post '/' do
    if params[:url] and not params[:url].empty?
      @shortcode = get_new_code 5
      Redis.new.setnx "links:#{@shortcode}", params[:url]
    end
    haml :index
  end

  get '/:shortcode' do
    @url = Redis.new.get "links:#{params[:shortcode]}"
    redirect @url || '/'
  end

end