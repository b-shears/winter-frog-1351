require 'rails_helper'

RSpec.describe 'plot index page' do
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

    visit "/plots"
  end

  it 'shows a list of all plot numbers' do
    expect(page).to have_content(@plot_1.number)
    expect(page).to have_content(@plot_2.number)
    expect(page).to have_content(@plot_3.number)
    expect(page).to have_content(@plot_4.number)
    expect(page).to have_content(@plot_5.number)
  end

  it 'displays all the names of the plants in each plot' do
    within("#plot-#{@plot_1.id}") do
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_content(@plant_2.name)
      expect(page).to_not have_content(@plant_3.name)
    end

    within("#plot-#{@plot_2.id}") do
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_content(@plant_2.name)
      expect(page).to_not have_content(@plant_3.name)
    end

    within("#plot-#{@plot_3.id}") do
      expect(page).to have_content(@plant_4.name)
      expect(page).to have_content(@plant_5.name)
      expect(page).to_not have_content(@plant_3.name)
    end

    within("#plot-#{@plot_4.id}") do
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_content(@plant_2.name)
      expect(page).to_not have_content(@plant_5.name)
    end

    within("#plot-#{@plot_5.id}") do
      expect(page).to_not have_content(@plant_1.name)
      expect(page).to_not have_content(@plant_2.name)
      expect(page).to_not have_content(@plant_3.name)
      expect(page).to_not have_content(@plant_4.name)
      expect(page).to_not have_content(@plant_5.name)
    end
  end

  it 'should have a link to remove a plant from a plot' do
    within("#plot-#{@plot_1.id}") do
      within("#plant-#{@plant_1.id}") do
        click_link 'Remove Plant'
      end
      expect(current_path).to eq("/plots")
      expect(page).to_not have_content(@plant_1.name)
    end
  end
end
