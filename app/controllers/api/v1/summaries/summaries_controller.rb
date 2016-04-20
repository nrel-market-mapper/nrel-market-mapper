module Api
  module V1
    module Summaries
      class SummariesController < ApiController
        def index
          if params[:state]
            respond_with State.find_by(abbr: params[:state]).data
          else
            respond_with State.find_by(abbr: "US").data
          end
        end
      end
    end
  end
end
