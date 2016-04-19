class StatesController < ApplicationController
  def index
  end

  def new
    DatabaseLoader.seed
    redirect_to root_path
  end
end
