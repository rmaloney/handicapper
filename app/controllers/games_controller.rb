class GamesController < ApplicationController

  before_filter :authenticate_user!
  #before_filter :play_count
  load_and_authorize_resource

   

  #Loads the current weeks games (Those open to plays)
  # GET /games
  # GET /games.json
  def index
    @current_week = 1
    @games = Game.where(:week => @current_week)
    @play_count = Play.open.where(:user_id => current_user.id).length
    @remaining = 6 - @play_count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  #Load and paginate the full schedule
  def schedule
    start = Time.parse('2012-09-05')
    @games = Game.where(:start_date => (start)..start + 7.days)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    @home_stats = Game.matchup_stats(@game.home_team)
    @visitor_stats = Game.matchup_stats(@game.visitor_team)

    if current_user.has_play?(params[:id])
      @message = "You have a a pending play on this game."
    end
    session[:game_id] = @game.id
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private

  def get_user
    @current_user = current_user
  end
end
