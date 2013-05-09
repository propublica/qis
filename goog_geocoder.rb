require 'uri'
require 'net/http'
require 'base64'
require 'openssl'
require 'json'


class GoogGeocoder
  CLIENT_ID = ::CREDENTIALS['google_client_id']
  KEY       = ::CREDENTIALS['google_key']
  PATH = CLIENT_ID && KEY ? "/maps/api/geocode/json?sensor=false&client=#{CLIENT_ID}" : "/maps/api/geocode/json?sensor=false"

  def initialize(address)
    @address = address
    @path = "#{PATH}&address=#{URI.encode @address}"
    geocode!
  end

  def resp
    JSON.parse @resp
  end

  private

  def geocode!
    if CLIENT_ID
      sign!
      @resp = Net::HTTP.get("maps.googleapis.com", "#{@path}&signature=#{@key}")
    else
      @resp = Net::HTTP.get("maps.googleapis.com", "#{@path}")      
    end
  end

  def sign!
    signer = OpenSSL::Digest::Digest.new('sha1')
    digest = OpenSSL::HMAC.digest(signer, Base64.decode64(KEY.tr('-_','+/')), @path)
    @key = Base64.encode64(digest).tr('+/','-_').strip
  end
end
