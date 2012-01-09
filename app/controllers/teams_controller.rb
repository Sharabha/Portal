class TeamsController < ApplicationController

  load_and_authorize_resource :except => :index

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team        =  Team.find(params[:id])
    @invitations =  @team.invitations

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    params[:team][:leader_id] = current_user.id
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        @team_membership = TeamMembership.new({
            :team_id => @team.id,
            :competition_id => params[:competition_id]
        })
        if @team_membership.save
          format.html { redirect_to @team, notice: 'Team was successfully created.' }
          format.json { render json: @team, status: :created, location: @team }
        else
          format.html { render action: "new" }
          format.json { render json: @team_membership.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :ok }
    end
  end
end
