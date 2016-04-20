module Api
  module V1
    module Summaries
      class SummariesController < ApiController
        def index
          respond_with State.find_by(abbr: "US").data
        end
      end
    end
  end
end
