class EventUsersController < ApplicationController
  before_action :set_event_user, only: [:show, :edit, :update, :destroy]

  # GET /event_users
  # GET /event_users.json
  def index
    @event_users = EventUser.all
  end

  # GET /event_users/1
  # GET /event_users/1.json
  def show
  end

  # GET /event_users/new
  def new
    @event_user = EventUser.new
  end

  # GET /event_users/1/edit
  def edit
  end

  # POST /event_users
  # POST /event_users.json
  def create
    @event_user = EventUser.new(event_user_params)

    respond_to do |format|
      if @event_user.save
        format.html { redirect_to @event_user, notice: 'Event user was successfully created.' }
        format.json { render :show, status: :created, location: @event_user }
      else
        format.html { render :new }
        format.json { render json: @event_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_users/1
  # PATCH/PUT /event_users/1.json
  def update
    respond_to do |format|
      if @event_user.update(event_user_params)
        format.html { redirect_to @event_user, notice: 'Event user was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_user }
      else
        format.html { render :edit }
        format.json { render json: @event_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_users/1
  # DELETE /event_users/1.json
  def destroy
    @event_user.destroy
    respond_to do |format|
      format.html { redirect_to event_users_url, notice: 'Event user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_user
      @event_user = EventUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_user_params
      params.require(:event_user).permit(:user_id, :event_id)
    end
end
