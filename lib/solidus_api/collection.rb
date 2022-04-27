module SolidusApi
  class Collection
    attr_reader :data, :count, :current_page, :pages, :per_page, :total_count

    def self.from_response(response, key:, type:)
      body = response.body
      if key
        new(
          data: body[key].map { |attrs| type.new(attrs) },
          count: body.dig("count"),
          current_page: body.dig("current_page"),
          pages: body.dig("pages"),
          per_page: body.dig("per_page"),
          total_count: body.dig("total_count")
        )
      else
        new(
          data: body.map { |attrs| type.new(attrs) }
        )
      end
    end

    def initialize(data:, count: nil, current_page: nil, pages: nil, per_page: nil, total_count: nil)
      @data = data
      @count = count
      @current_page = current_page
      @pages = pages
      @per_page = per_page
      @total_count = total_count
    end
  end
end
