# lib/resinio/application.rb
require 'faraday'
require 'json'

module ResinIO
  class Application
    attr_reader :id, :app_name, :commit, :device_type
    def initialize(attributes)

      @id = attributes['id']
      @app_name = attributes['app_name']
      @commit = attributes['commit']
      @device_type = attributes['device_type']

    end

    def self.find(id)
      conn = Faraday.new(url: "#{API_URL}/application(#{id})") do |faraday|
        faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
        faraday.headers['Content-Type'] = 'application/json' # form-encode POST params
        faraday.headers['Authorization'] = "Bearer #{ENV['RESIN_API_KEY']}" # form-encode POST params
        # faraday.request :url_encoded # form-encode POST params
        # faraday.response :logger                  # log requests to $stdout
      end
      response = conn.get
      parsed_response = JSON.parse(response.body)
      attributes = parsed_response['d'][0]
      # byebug
      new(attributes)
    end
    #
    # def self.all
    #
    #   conn = Faraday.new(url: "#{API_URL}/device") do |faraday|
    #     faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    #     faraday.headers['Content-Type'] = 'application/json' # form-encode POST params
    #     faraday.headers['Authorization'] = "Bearer #{ENV['RESIN_API_KEY']}" # form-encode POST params
    #   end
    #   response = conn.get
    #   parsed_response = JSON.parse(response.body)
    #   devices = parsed_response['d']
    #   result = devices.map{|device| new(device) }
    #   # byebug
    # end

    # private
    #
    # def minion_method
    #   # do something
    # end
  end
end
