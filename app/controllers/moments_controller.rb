class MomentsController < ApplicationController
  before_action :set_moment, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def tag
    @tags = Moment.tag_counts_on(:tags)
    @moments = Moment.tagged_with(params[:id]).page(params[:page]).per(per_page)
    render action: 'index'
  end

  def upvote
    @moment.upvote_by current_user
    redirect_to moments_path
  end

  def downvote
    @moment.downvote_by current_user
    redirect_to moments_path
  end

  # GET /moments
  # GET /moments.json
  def index
    @tags = Moment.tag_counts_on(:tags)
    @moments = Moment.all.page(params[:page]).per(per_page)
  end

  # GET /moments/1
  # GET /moments/1.json
  def show
  end

  # GET /moments/new
  def new
    @moment = Moment.new
  end

  # GET /moments/1/edit
  def edit
  end

  # POST /moments
  # POST /moments.json
  def create
    @moment = Moment.new(moment_params)

    respond_to do |format|
      if @moment.save
        format.html { redirect_to @moment, notice: 'Moment was successfully created.' }
        format.json { render :show, status: :created, location: @moment }
      else
        format.html { render :new }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moments/1
  # PATCH/PUT /moments/1.json
  def update
    respond_to do |format|
      if @moment.update(moment_params)
        format.html { redirect_to @moment, notice: 'Moment was successfully updated.' }
        format.json { render :show, status: :ok, location: @moment }
      else
        format.html { render :edit }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moments/1
  # DELETE /moments/1.json
  def destroy
    @moment.destroy
    respond_to do |format|
      format.html { redirect_to moments_url, notice: 'Moment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moment
      @moment = Moment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moment_params
      params.require(:moment).permit(:start, :stop, :name, :description, :youtube_vid, :user_id, :tag_list)
    end
end
