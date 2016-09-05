class ProduktsController < ApplicationController
  before_action :set_produkt, only: [:show, :edit, :update, :destroy]

  # GET /produkts
  def index
    @produkts = Produkt.all
  end

  # GET /produkts/1
  def show
  end

  # GET /produkts/new
  def new
    @produkt = Produkt.new
  end

  # GET /produkts/1/edit
  def edit
  end

  # POST /produkts
  def create
    @produkt = Produkt.new(produkt_params)

    if @produkt.save
      redirect_to @produkt, notice: 'Produkt was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /produkts/1
  def update
    if @produkt.update(produkt_params)
      redirect_to @produkt, notice: 'Produkt was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /produkts/1
  def destroy
    @produkt.destroy
    redirect_to produkts_url, notice: 'Produkt was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produkt
      @produkt = Produkt.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def produkt_params
      params.require(:produkt).permit(:title, :price)
    end
end
