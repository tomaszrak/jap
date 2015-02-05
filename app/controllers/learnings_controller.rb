class LearningsController < ApplicationController
  load_and_authorize_resource

  def index
    @learnings = Learning.where(user: current_user)
  end
end
