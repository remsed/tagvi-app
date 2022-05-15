class MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: { message: 'You are authenticated!' }
  end
end
