## Resources
gem 'sinatra', :version => '1.0'
require 'sinatra'
require 'geoip'
require 'json'



## Application

get '/' do
  %Q{
    <body style='line-height: 1.8em; font-family: Archer, Museo, Helvetica, Georgia; font-size 25px; text-align: center; padding-top: 20%;'>
      Get to '/' with an ip address to lookup the server location in JSON. Example:
      <pre style='font-family: Iconsolata, monospace;background-color:#EEE'>curl http://#{request.host}/207.97.227.239</pre>
      <br />
      <form action=/ method=GET onsubmit='if(\"\"==this.url.value)return false;else{this.action=\"/\"+this.ip.value}'>
        <label for='ip'>IP address: </label>
        <input type=text name='ip'/>
        <input type=submit value='Lookup!' />
      </form>
    </body
}
end

get '/:ip' do
  pass unless params[:ip] =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/

  data = GeoIP.new('vendor/GeoLiteCity.dat').city(params[:ip])

  content_type 'application/json'

  encode(data).to_json

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