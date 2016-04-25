class StatesController < ApplicationController
  def index
  end

  def show
    @states = State.where.not(abbr: "US").order(:name)
  end
end
