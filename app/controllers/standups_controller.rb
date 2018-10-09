class StandupsController < ApplicationController
  before_action :set_standup, only: [:show, :update, :destroy]

  # GET /standups
  # GET /standups.json
  def index
    redirect_to(root_path)
  end

  # GET /standups/1
  # GET /standups/1.json
  def show
  end

  # GET /standups/new
  def new
    return if check_for_blank_date
    return if check_for_existance
    @standup = Standup.new
  end

  # GET /standups/1/edit
  def edit
    return if check_for_blank_date
    return if check_for_existance
    @standup = Standup.find_by(
      user_id: current_user.id,
      standup_date: current_date
    )
  end

  # POST /standups
  # POST /standups.json
  def create
    @standup = Standup.new(standup_params)
    @standup.user = current_user

    respond_to do |format|
      if @standup.save
        format.html { redirect_to @standup, notice: 'Standup was successfully created.' }
        format.json { render :show, status: :created, location: @standup }
      else
        format.html { render :new }
        format.json { render json: @standup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /standups/1
  # PATCH/PUT /standups/1.json
  def update
    respond_to do |format|
      if @standup.update(standup_params)
        format.html { redirect_to @standup, notice: 'Standup was successfully updated.' }
        format.json { render :show, status: :ok, location: @standup }
      else
        format.html { render :edit }
        format.json { render json: @standup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /standups/1
  # DELETE /standups/1.json
  def destroy
    @standup.destroy
    respond_to do |format|
      format.html { redirect_to standups_url, notice: 'Standup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standup
      @standup = Standup.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def standup_params
      params.require(:standup).permit(:standup_date, dids_attributes: [:id, :title, :_destroy], todos_attributes: [:id, :title, :_destroy], blockers_attributes: [:id, :title, :_destroy])
    end

    def check_for_blank_date
      if params[:date].blank?
        redirect_to(
          update_date_path(
            date: Date.today.iso8601,
            reload_path: "/s/#{action_name}/#{Date.today.iso8601}"
          )
        ) and return true
      end
    end

    def check_for_existance
      standup = Standup.find_by(
        user_id: current_user.id, standup_date: current_date
      )
      if standup.present? && action_name == 'new'
        redirect_to(edit_standup_path(date: current_date)) and return true
      elsif standup.nil? && action_name == 'edit'
        redirect_to(new_standup_path(date: current_date)) and return true
      end
    end
end
