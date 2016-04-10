class AchievementsController < ApplicationController
  before_action :set_achievement, only: [:show, :edit, :update, :destroy, :complete]
  before_action :authorize, only: [:complete]

  def complete
    unless @achievement.users.include? current_user
      UserAchievement.create user: current_user, achievement: @achievement
      redirect_to achievements_path, notice: "Well done!"
    else
      ua = UserAchievement.find_by user: current_user, achievement: @achievement
      ua.destroy
      redirect_to achievements_path, notice: "Too bad..."
    end
  end

  # GET /achievements
  # GET /achievements.json
  def index
    @achievements = Achievement.all
  end

  # GET /achievements/1
  # GET /achievements/1.json
  def show
    @users = @achievement.users
  end

  # GET /achievements/new
  def new
    @achievement = Achievement.new
  end

  # GET /achievements/1/edit
  def edit
  end

  # POST /achievements
  # POST /achievements.json
  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.poke_name = @achievement.poke_name.downcase
    respond_to do |format|
      if @achievement.save
        format.html { redirect_to @achievement, notice: 'Achievement was successfully created.' }
        format.json { render :show, status: :created, location: @achievement }
      else
        format.html { render :new }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /achievements/1
  # PATCH/PUT /achievements/1.json
  def update
    respond_to do |format|
      if @achievement.update(achievement_params)
        format.html { redirect_to @achievement, notice: 'Achievement was successfully updated.' }
        format.json { render :show, status: :ok, location: @achievement }
      else
        format.html { render :edit }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /achievements/1
  # DELETE /achievements/1.json
  def destroy
    @achievement.destroy
    respond_to do |format|
      format.html { redirect_to achievements_url, notice: 'Achievement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_achievement
      @achievement = Achievement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def achievement_params
      params.require(:achievement).permit(:poke_name, :title)
    end
end
