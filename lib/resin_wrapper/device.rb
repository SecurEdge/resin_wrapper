# lib/benzinator/car.rb
require 'faraday'
require 'json'

API_URL = 'https://api.resin.io/v4'.freeze

module ResinWrapper
  class Device
    attr_reader :id, :uuid, :name
    def initialize(attributes)

      @id = attributes['id']
      @uuid = attributes['uuid']
      @name = attributes['device_name']

    end

    def self.find(id)
      conn = Faraday.new(url: "#{API_URL}/device(#{id})") do |faraday|
        faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
        faraday.headers['Content-Type'] = 'application/json' # form-encode POST params
        faraday.headers['Authorization'] = "Bearer #{ENV['RESIN_API_KEY']}" # form-encode POST params
        # faraday.request :url_encoded # form-encode POST params
        # faraday.response :logger                  # log requests to $stdout
      end
      response = conn.get
      parsed_response = JSON.parse(response.body)
      attributes = parsed_response['d'][0]
      new(attributes)
    end

    def self.all

      conn = Faraday.new(url: "#{API_URL}/device") do |faraday|
        faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
        faraday.headers['Content-Type'] = 'application/json' # form-encode POST params
        faraday.headers['Authorization'] = "Bearer #{ENV['RESIN_API_KEY']}" # form-encode POST params
      end
      response = conn.get
      parsed_response = JSON.parse(response.body)
      devices = parsed_response['d']
      result = devices.map{|device| new(device) }
      # byebug
    end

    # private
    #
    # def minion_method
    #   # do something
    # end
  end
end
