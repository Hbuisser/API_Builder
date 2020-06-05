class Api::V1::RestaurantsController < Api::V1::BaseController

  # def show
  #   @restaurant = Restaurant.find(params[:id])
  #   authorize @restaurant
  # end
  before_action :set_restaurant, only: [ :show, :update ]

  def index
    if params[:search].blank?
      @restaurants = policy_scope(Restaurant)
    else
      @restaurants = policy_scope(Restaurant).where('name ILIKE ?',"%#{params[:search]}%")
    end
  end

  def show
  end

  def update
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant  # For Pundit
  end
end
