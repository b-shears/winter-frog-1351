class Garden < ApplicationRecord
  has_many :plots

  def harvest_below_100_days
    plots.joins(:plants)
    .select('plants.*')
    .where("plants.days_to_harvest < ?", 100)
    .distinct
    .pluck(:name)
  end
end
