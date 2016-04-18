class NrelService
  def initialize
    @_connection = Faraday.new("https://developer.nrel.gov")
    connection.params["api_key"] = ENV["NREL_API_KEY"]
  end

  def index
    parse(connection.get("/api/solar/open_pv/installs/index"))
  end

  private

    def connection
      @_connection
    end

    def parse(result)
      JSON.parse(result.body).deep_symbolize_keys
    end
end
