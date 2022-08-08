class PlotPlantsController < ApplicationController
  def destroy
    plot = Plot.find(params[:plot_id])
    plant = Plant.find(params[:plant_id])
    plot_plant = plant.plot_plants.find_by(plant_id: params[:plant_id])
    plot_plant.destroy
    redirect_to '/plots'
  end
end
