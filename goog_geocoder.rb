require 'uri'
require 'net/http'
require 'base64'
require 'openssl'
require 'json'


class GoogGeocoder
  CLIENT_ID = "YOURS"
  KEY = "YOURS"
  PATH = "/maps/api/geocode/json?sensor=false&client=#{CLIENT_ID}"

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
    sign!
    @resp = Net::HTTP.get("maps.googleapis.com", "#{@path}&signature=#{@key}")
  end

  def sign!
    signer = OpenSSL::Digest::Digest.new('sha1')
    digest = OpenSSL::HMAC.digest(signer, Base64.decode64(KEY.tr('-_','+/')), @path)
    @key = Base64.encode64(digest).tr('+/','-_').strip
  end
end
