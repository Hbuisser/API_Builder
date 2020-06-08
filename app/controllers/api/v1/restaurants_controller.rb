class Api::V1::RestaurantsController < Api::V1::BaseController

  before_action :set_restaurant, only: [ :show, :update ]

  def index
    if params[:search].blank?
      @restaurants = policy_scope(Restaurant)
    else
      @restaurants = policy_scope(Restaurant).where('name ILIKE ?',"%#{params[:search]}%")
    end
  end

  def show
    #@restaurant = Restaurant.find(params[:id])
  end

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant, :create
    if @restaurant.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant, :show # For Pundit
  end
  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end
  def render_error
    render json: { errors: @restaurant.errors.full_messages },
      status: :unprocessable_entity
  end
end
