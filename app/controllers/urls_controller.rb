class UrlsController < ApplicationController

  def index
    
  end

  def create
    url = params[:url]
    unless @short_url = $redis.hget('url', url)
      begin
        @short_url = SecureRandom.urlsafe_base64(6)
      end while $redis.hget 'short_url', @short_url

      $redis.hset 'short_url', @short_url, url
      $redis.hset 'url', url, @short_url
    end
    render json: { short_url: root_url+@short_url }
  end

  def redirect
    url = $redis.hget 'short_url', params[:short_url]
    url = 'http://' + url unless url =~ /^http/
    redirect_to url
  end
end
