module SolidusApi
  class Client
    attr_reader :api_key, :api_endpoint, :adapter

    def initialize(api_key:, api_endpoint:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @api_endpoint = api_endpoint
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def taxon
      TaxonResource.new(self)
    end

    def taxonomy
      TaxonomyResource.new(self)
    end

    def product
      ProductResource.new(self)
    end

    def connection
      @connection ||= Faraday.new(api_endpoint) do |conn|
        conn.request :authorization, :Bearer, api_key
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end
    end
  end
end
