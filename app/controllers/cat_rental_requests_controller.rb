class CatRentalRequestsController < ApplicationController
  def index
    @requests = CatRentalRequest.all
    render :index
  end

  def show
    @request = CatRentalRequest.find(params[:id])
    render :show
  end

  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(params[:requests])
    if @request.save
      redirect_to requests_url(@request)
    else
      render :new
    end
  end

  def edit
    @request = CatRentalRequest.find(params[:id])
    render :edit
  end

  def update
    @request = CatRentalRequest.find(params[:id])
    if @request.update_attributes(params[:requests])
      redirect_to requests_url(@request)
    else
      render :edit
    end
  end
end
