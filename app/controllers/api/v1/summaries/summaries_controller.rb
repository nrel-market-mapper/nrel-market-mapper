module Api
  module V1
    module Summaries
      class SummariesController < ApiController
        def index
          respond_with State.find_by(abbr: "US"), serializer: StateSerializer
        end

        def show
          respond_with State.find_by(abbr: params[:state]), serializer: StateSerializer
        end
      end
    end
  end
end
