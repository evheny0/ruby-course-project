class ChaptersController < ApplicationController
  before_action :set_creative
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = Chapter.all
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
  end

  # GET /chapters/new
  def new
    @chapter = @creative.chapters.build
    respond_to do |format|
      format.json { render "_form.html", :layout => false }
    end
  end

  # GET /chapters/1/edit
  def edit
    respond_to do |format|
      format.html { render "edit" }
      format.json { render "_form.html", :layout => false }
    end
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = @creative.chapters.create(chapter_params)
    @chapter.order = (@creative.chapters.maximum("order") || -1) + 1
    respond_to do |format|
      if @chapter.save
        format.json { render action: 'show', status: :created }
      else
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.json { render action: 'show' }
      else
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_creative
      @creative = Creative.find(params[:creative_id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = @creative.chapters.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :content)
    end
end
