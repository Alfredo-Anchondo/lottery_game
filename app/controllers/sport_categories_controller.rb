class SportCategoriesController < ApplicationController
  before_action :set_sport_category, only: [:show, :edit, :update, :destroy]
   before_action :data, only: [:index, :new, :create, :edit, :update]
  # GET /sport_categories
  # GET /sport_categories.json
  def index
    @sport_categories = SportCategory.all
  end

  # GET /sport_categories/1
  # GET /sport_categories/1.json
  def show
  end

  # GET /sport_categories/new
  def new
    @sport_category = SportCategory.new
  end

  # GET /sport_categories/1/edit
  def edit
  end

  # POST /sport_categories
  # POST /sport_categories.json
  def create
    @sport_category = SportCategory.new(sport_category_params)

    respond_to do |format|
      if @sport_category.save
        format.html { redirect_to @sport_category, notice: 'Sport category was successfully created.' }
        format.json { render :show, status: :created, location: @sport_category }
      else
        format.html { render :new }
        format.json { render json: @sport_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sport_categories/1
  # PATCH/PUT /sport_categories/1.json
  def update
    respond_to do |format|
      if @sport_category.update(sport_category_params)
        format.html { redirect_to @sport_category, notice: 'Sport category was successfully updated.' }
        format.json { render :show, status: :ok, location: @sport_category }
      else
        format.html { render :edit }
        format.json { render json: @sport_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sport_categories/1
  # DELETE /sport_categories/1.json
  def destroy
    @sport_category.destroy
    respond_to do |format|
      format.html { redirect_to sport_categories_url, notice: 'Sport category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport_category
      @sport_category = SportCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sport_category_params
      params.require(:sport_category).permit(:sport_id, :category_id)
    end
end
