# frozen_string_literal: true

# This controller implements calendar actions
class CalendarsController < ApplicationController
  before_action :set_calendar, only: %i[show update destroy]
  before_action :authenticate_user!

  # GET /calendars
  def index
    @calendars = current_user.calendars

    render json: @calendars
  end

  # GET /calendars/1
  def show
    render json: @calendar
  end

  # POST /calendars
  def create
    calendar_params_obj = calendar_params
    calendar_status = calendar_params_obj[:active]
    set_calendar_status if active?(calendar_status)
    @calendar = current_user.calendars.create(calendar_params_obj)
    if @calendar.save
      render json: @calendar, status: :created, location: @calendar
    else
      render json: @calendar.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /calendars/1
  def update
    # calendar_status = calendar_params[:active]
    # calendar_name = calendar_params[:name]

    # if active?(calendar_status)

    # if
    #   active_calendar = current_user.calendars.find_by active: 'true'
    #   active_calendar.active = 'false'
    # else
    #   active_calendar = current_user.calendars.find_by active: 'false'
    #   active_calendar.active = 'true'
    # end
    # active_calendar.save

    if @calendar.update(calendar_params)
      render json: @calendar
    else
      render json: @calendar.errors, status: :unprocessable_entity
    end
  end

  # DELETE /calendars/1
  def destroy
    @calendar.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_calendar
    @calendar = Calendar.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def calendar_params
    params.require(:calendar).permit(:name, :active)
  end

  # Set active calendar status to false
  def set_calendar_status
    active_calendar = current_user.calendars.find_by active: 'true'
    active_calendar.active = 'false'
    active_calendar.save
  end

  # Verify if value is true
  def active?(obj)
    obj.to_s.downcase == 'true'
  end
end
