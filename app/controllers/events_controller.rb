class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :join]
  before_action :authorize, only: [:join, :create, :new]
  before_action :correct, except: [:join, :index, :show, :create, :new]

  # Joins current user to event
  def join
    if (not @event.users.include? current_user)
      EventUser.create(user: current_user, event: @event)
      redirect_to events_path, notice: "You are now participating."
    else
      ev = EventUser.find_by user: current_user, event: @event
      ev.destroy
      redirect_to events_path, notice: "Removed you from the event."
    end
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.order(:time)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @users = @event.users
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:time, :place)
    end
end
