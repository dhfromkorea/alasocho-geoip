## Resources
gem 'sinatra', :version => '1.0'
require 'sinatra'
require 'geoip'
require 'i18n'
require 'active_support'


## Application

configure :production do
  ENV['APP_ROOT'] ||= File.dirname(__FILE__)
  begin
    $:.unshift "#{ENV['APP_ROOT']}/vendor/plugins/newrelic_rpm/lib"
    require 'newrelic_rpm'
  rescue LoadError
  rescue
  end
end


get '/' do
  callback = params['callback']
  content_type :js
  ip =  request.ip
  json_result = ip_details(ip)
  "#{callback}(#{json_result})"
end




get '/:ip' do
  callback = params['callback']
  content_type :js
  ip = params[:ip]
  json_result = ip_details(ip)
  "#{callback}(#{json_result})"
end


def ip_details(ip)
  data_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'vendor', 'GeoLiteCity.dat'))
  
  pass unless ip =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/

  data = GeoIP.new(data_file).city(ip)

  content_type 'application/json;charset=ascii-8bit'
  headers['Cache-Control'] = "public; max-age=#{365*24*60*60}"

  return "{}" unless data

  ActiveSupport::JSON.encode(encode(data))
end


def encode data
  {
    # * The host or IP address string as requested
    :ip => data.shift,
    # * The IP address string after looking up the host
    :ip_lookup => data.shift,
    # * The GeoIP country-ID as an integer
    # :country_id => data.shift,
    # * The ISO3166-1 two-character country code
    :country_code => data.shift,
    # * The ISO3166-2 three-character country code
    :country_code_long => data.shift,
    # * The ISO3166 English-language name of the country
    :country => data.shift,
    # * The two-character continent code
    :continent => data.shift,
    # * The region name
    :region => data.shift,
    # * The city name
    :city => data.shift,
    # * The postal code
    :postal_code => data.shift,
    # * The latitude
    :lat => data.shift,
    # * The longitude
    :lng => data.shift,
    # * The USA dma_code and area_code, if available (REV1 City database)
    :dma_code => data.shift,
    :area_code => data.shift,
    # Timezone, if available
    :timezone => data.shift
  }
end
