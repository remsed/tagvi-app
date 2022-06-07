# frozen_string_literal: true

# This controller implements event actions
class EventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]
  before_action :authenticate_user!

  # GET /events
  def index
    @events = current_user.events.where(calendar_id: active_calendar_id?)

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private

  # Return active calendar ID
  def active_calendar_id?
    active_calendar = current_user.calendars.find_by active: 'true'
    active_calendar[:id]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :body, :eventtime, :author, :calendar_id)
  end
end
