class CreativesController < ApplicationController
  before_action :set_creative, only: [:show, :edit, :update, :destroy, :reorder_chapters]
  before_action :string_of_tags_to_array, only: [:create, :update]
  before_action :check_rights, only: [:edit, :update, :destroy, :reorder_chapters]

  # GET /creatives
  # GET /creatives.json
  def index
    @creatives = Creative.paginate(:page => params[:page])
  end

  # GET /creatives/1
  # GET /creatives/1.json
  def show
    renderer = Redcarpet::Render::HTML.new(:filter_html => true)
    @markdown = Redcarpet::Markdown.new(renderer, :autolink => true)
  end

  # GET /creatives/new
  def new
    @creative = Creative.new
  end

  # GET /creatives/1/edit
  def edit
    respond_to do |format|
      format.html { render "edit" }
      format.json { render "_form.html", :layout => false }
    end
  end

  # POST /creatives
  # POST /creatives.json
  def create
    @creative = Creative.new({ :user_id => current_user.id , :num_of_votes => 0 }.merge(creative_params))
    respond_to do |format|
      if @creative.save
        add_tags_to_creative
        format.html { redirect_to @creative, notice: 'Creative was successfully created.' }
        format.json { render action: 'show', status: :created, location: @creative }
      else
        format.html { render action: 'new' }
        format.json { render json: @creative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /creatives/1
  # PATCH/PUT /creatives/1.json
  def update
    delete_tags_from_creative
    add_tags_to_creative
    respond_to do |format|
      if @creative.update(creative_params)
        format.html { redirect_to @creative, notice: 'Creative was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @creative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creatives/1
  # DELETE /creatives/1.json
  def destroy
    delete_tags_from_creative
    @creative.destroy
    respond_to do |format|
      format.html { redirect_to creatives_url }
      format.json { head :no_content }
    end
  end

  def reorder_chapters
    new_order = params[:order].scan(/\d+/)
    chapters = @creative.chapters

    new_order.each.with_index do |i, position|
      chapter = chapters.find_by(:id => i.to_i)
      chapter.order = position
      chapter.save
    end
    render :nothing => true

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creative
      @creative = Creative.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def creative_params
      params.require(:creative).permit(:title, :description)
    end

    def check_rights
      authorize! :update, @creative
    end

    def string_of_tags_to_array
      string_tags = params[:tags]
      @tags = string_tags.scan(/[A-Za-zа-яА-Я\d]+/)
    end

    def add_tags_to_creative
      @tags.each do |t|
        tag = Tag.where(:value => t).last
        if tag
          tag.ammount += 1
          tag.save
          @creative.tags << tag
        else
          @creative.tags.create(:value => t, :ammount => 1)
        end
      end
    end

    def delete_tags_from_creative
      @creative.tags.to_a.each do |tag|
        if tag.ammount == 1
          tag.destroy
        else
          tag.ammount -= 1
          tag.save
        end
        @creative.tags.delete(tag)
      end
    end
end
