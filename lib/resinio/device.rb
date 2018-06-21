# lib/resinio/device.rb
require 'faraday'
require 'json'

module ResinIO
  class Device
    attr_reader :id, :uuid, :device_name, :device_type,
                :is_online, :status, :os_variant, :location,
                :commit, :os_version, :supervisor_version, :longitude, :latitude
    def initialize(attributes)

      @id = attributes['id']
      @uuid = attributes['uuid']
      @device_name = attributes['device_name']
      @device_type = attributes['device_type']
      @is_online = attributes['is_online']
      @status = attributes['status']
      @os_variant = attributes['os_variant']
      @location = attributes['location']
      @commit = attributes['is_on__commit']
      @os_version = attributes['os_version']
      @supervisor_version = attributes['supervisor_version']
      @longitude = attributes['longitude']
      @latitude = attributes['latitude']

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
      # byebug
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
