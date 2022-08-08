require 'rails_helper'

RSpec.describe 'gardens show page' do
  before :each do
    @garden = Garden.create(name: 'Skeeters Garden', organic: false)

    @plot_1 = @garden.plots.create!(number: 8 , size: "large", direction: "north")
    @plot_2 = @garden.plots.create!(number: 7, size: "medium", direction: "west")
    @plot_3 = @garden.plots.create!(number: 9, size: "small", direction: "east")
    @plot_4 = @garden.plots.create!(number: 1, size: "large", direction: "south")
    @plot_5 = @garden.plots.create!(number: 3, size: "small", direction: "north")

    @plant_1 = Plant.create!(name: 'Black Crim Tomato', description: 'yum', days_to_harvest: 101)
    @plant_2 = Plant.create!(name: 'Habanero', description: 'spicy', days_to_harvest: 76)
    @plant_3 = Plant.create!(name: 'Radish', description: 'root vegetable', days_to_harvest: 120)
    @plant_4 = Plant.create!(name: 'Green Beans', description: 'beans', days_to_harvest: 99)
    @plant_5 = Plant.create!(name: 'Beets', description: 'beets!', days_to_harvest: 21)

    PlotPlant.create!(plot: @plot_1, plant: @plant_1)
    PlotPlant.create!(plot: @plot_1, plant: @plant_2)
    PlotPlant.create!(plot: @plot_2, plant: @plant_1)
    PlotPlant.create!(plot: @plot_2, plant: @plant_2)
    PlotPlant.create!(plot: @plot_3, plant: @plant_4)
    PlotPlant.create!(plot: @plot_3, plant: @plant_5)
    PlotPlant.create!(plot: @plot_4, plant: @plant_1)
    PlotPlant.create!(plot: @plot_4, plant: @plant_2)
    PlotPlant.create!(plot: @plot_4, plant: @plant_3)

    visit "/gardens/#{@garden.id}"
  end

  it 'shows all plants in the garden plot that take less than 100 days to harvest' do
    expect(page).to have_content(@plant_2.name)
    expect(page).to have_content(@plant_4.name)
    expect(page).to have_content(@plant_5.name)
    expect(page).to_not have_content(@plant_1.name)
    expect(page).to_not have_content(@plant_3.name)
  end

end
