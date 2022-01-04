class InstrumentsController < ApplicationController
  # add :sort_column, :sort_direction as helper methods so it can be accessed by application_helper.
  helper_method :sort_column, :sort_direction
  before_action :set_instrument, only: %i[ show edit update destroy ]

  # to sort an array of hashes by different keys
  def info
  instruments = [
    {"id":1,"title":"Piano","token":"piano","count":13},
    {"id":6,"title":"Bass Guitar","token":"bass","count":12},
    {"id":11,"title":"Viola","token":"viola","count":12},
    {"id":4,"title":"Synth","token":"synth","count":11},
    {"id":3,"title":"Keyboard","token":"keyboard","count":9},
    {"id":7,"title":"Saxophone","token":"saxophone","count":8},
    {"id":12,"title":"Flute","token":"flute","count":8},
    {"id":5,"title":"Drums","token":"drums","count":6},
    {"id":2,"title":"Guitar","token":"guitar","count":5},
    {"id":8,"title":"Violin","token":"violin","count":5},
    {"id":9,"title":"Vocals","token":"vocals","count":4},
    {"id":10,"title":"Cello","token":"cello","count":4}
    ]
    @sorted_instruments = instruments.sort_by! { |x| x[:id] }
  end

  # GET /instruments or /instruments.json
  def index
    # @instruments = Instrument.all
    @instruments = Instrument.order(sort_column + " " + sort_direction)
    #Go to http://localhost:3000/instruments?sort=ID&direction=desc
    logger.tagged("INSTRUMENT:") { logger.info "Instrument Column Names: #{Instrument.column_names}" }
    logger.tagged("INSTRUMENT:") { logger.info "sort_column: #{sort_column}" }
    logger.tagged("INSTRUMENT:") { logger.info "sort_direction: #{sort_direction}" }
  end

  # GET /instruments/1 or /instruments/1.json
  def show
  end

  # GET /instruments/new
  def new
    @instrument = Instrument.new
  end

  # GET /instruments/1/edit
  def edit
  end

  # POST /instruments or /instruments.json
  def create
    @instrument = Instrument.new(instrument_params)

    respond_to do |format|
      if @instrument.save
        format.html { redirect_to @instrument, notice: "Instrument was successfully created." }
        format.json { render :show, status: :created, location: @instrument }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instruments/1 or /instruments/1.json
  def update
    respond_to do |format|
      if @instrument.update(instrument_params)
        format.html { redirect_to @instrument, notice: "Instrument was successfully updated." }
        format.json { render :show, status: :ok, location: @instrument }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1 or /instruments/1.json
  def destroy
    @instrument.destroy
    respond_to do |format|
      format.html { redirect_to instruments_url, notice: "Instrument was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instrument_params
      params.require(:instrument).permit(:title, :token, :count)
    end

    # Sorting methods
    def sort_column
      if params[:sort] && Instrument.column_names.include?(params[:sort].downcase)
        return params[:sort]
      else
        return "id"
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
