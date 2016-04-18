class NrelService
  def initialize
    @_connection = Faraday.new("https://developer.nrel.gov")
    connection.params["api_key"] = ENV["NREL_API_KEY"]
  end

  def index(params=nil)
    parse(connection.get("/api/solar/open_pv/installs/index", params))
  end

  def summaries(params=nil)
    parse(connection.get("/api/solar/open_pv/installs/summaries", params))
  end

  private

    def connection
      @_connection
    end

    def parse(result)
      JSON.parse(result.body).deep_symbolize_keys
    end
end
