require 'net/http'

class HttpClient
  attr_reader :client

  def initialize(client = Net::HTTP)
    @client = client
  end

  def get(uri)
    uri = URI(uri)
    client.get(uri)
  end
end
