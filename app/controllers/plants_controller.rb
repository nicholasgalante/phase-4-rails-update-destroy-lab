class PlantsController < ApplicationController

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant_by_id
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end
  
  # PATCH /plants/:id
  def update
    plant = find_plant_by_id
    if plant
      plant.update(plant_params)
      render json: plant, status: :ok
    else 
      plant_not_found
    end
  end


  # DELETE /plants/:id
  def destroy
    plant = find_plant_by_id
    if plant
      plant.destroy  
      render json: {}, status: :no_content
    else 
      plant_not_found    
    end
  end


  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant_by_id
    Plant.find_by(id: params[:id])
  end

  def plant_not_found
    render json: { error: "Plant not found" }, status: :not_found
  end
end
