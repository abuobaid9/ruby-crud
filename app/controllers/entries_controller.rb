class EntriesController < ApplicationController
  before_action :set_entry, only: %i[show edit update destroy]

  # GET /entries or /entries.json
  def index
    @entries = Entry.where('created_at >= ?', Date.today)
  end

  # app/controllers/entries_controller.rb
  def weights
    @very_good = Entry.where('calories < ?', 200).group_by(&:meal_type)
    @good = Entry.where(calories: 200..400).group_by(&:meal_type)
    @not_good = Entry.where('calories > ?', 400).group_by(&:meal_type)
  end

  def search
    if params[:q].present?
      @entries = Entry.where('meal_type LIKE ?', '%' + params[:q] + '%')
      flash.now[:notice] = 'No entries were found.' if @entries.empty?
    else
      @entries = Entry.all
    end
  end

  # GET /entries/1 or /entries/1.json
  def show; end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit; end

  # POST /entries or /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to entry_url(@entry), notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entry_url(@entry), notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
    puts ' I happen  before action'
  end

  # Only allow a list of trusted parameters through.
  def entry_params
    params.require(:entry).permit(:meal_type, :calories, :proteins, :carbohydrater, :fats)
  end
end
