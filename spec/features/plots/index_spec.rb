require 'rails_helper'

RSpec.describe 'plot index page' do
  before :each do
    @garden = Garden.create(name: 'Maupin Garen', organic: false)

    @plot_1 = @garden.plots.create!(number: 12, size: "small", direction: "west")
    @plot_2 = @garden.plots.create!(number: 7, size: "medium", direction: "west")
    @plot_3 = @garden.plots.create!(number: 32, size: "small", direction: "east")
    @plot_4 = @garden.plots.create!(number: 1, size: "large", direction: "south")
    @plot_5 = @garden.plots.create!(number: 72, size: "large", direction: "north")

    @plant_1 = Plant.create!(name: 'Cherokee Purple', description: 'lots of sun', days_to_harvest: 90)
    @plant_2 = Plant.create!(name: 'Jalapeno', description: 'hot pepper', days_to_harvest: 75)
    @plant_3 = Plant.create!(name: 'Yukon Gold Potato', description: 'cooler temps and lot of water', days_to_harvest: 110)
    @plant_4 = Plant.create!(name: 'Basil', description: 'prun before it flowers', days_to_harvest: 30)
    @plant_5 = Plant.create!(name: 'Calantro', description: 'flowers quickly', days_to_harvest: 20)

    PlotPlant.create!(plot: @plot_1, plant: @plant_1)
    PlotPlant.create!(plot: @plot_1, plant: @plant_2)
    PlotPlant.create!(plot: @plot_2, plant: @plant_1)
    PlotPlant.create!(plot: @plot_2, plant: @plant_2)
    PlotPlant.create!(plot: @plot_3, plant: @plant_4)
    PlotPlant.create!(plot: @plot_3, plant: @plant_5)
    PlotPlant.create!(plot: @plot_4, plant: @plant_1)
    PlotPlant.create!(plot: @plot_4, plant: @plant_2)
    PlotPlant.create!(plot: @plot_4, plant: @plant_3)
