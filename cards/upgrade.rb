require 'squib'
require_relative 'card'

# Layout methods and deck data for Asset card types
class Upgrade < Card
  def initialize(data_file)
    @data_file = data_file
  end

  def data
    Squib.csv file: @data_file
  end

  def name
    "upgrades"
  end

  def layout
    ["layouts/upgrade.yml"]
  end

  # Takes the api object defining the Squib DSL and the deck data to render
  def render(api, data, index = :all)
    title api, data['name'], index

    construction api, data['construction'], index
    bombardment api, data['bombardment'], index

    abilities api, data['abilities'], index
  end

  private

  def title(api, title_data, index)
    api.text layout: 'title', str: title_data, range: index
  end

  def bombardment(api, bombardment_data, index)
    bombardment_data = bombardment_data.map do |bombardment|
      ":bombardment: #{bombardment}"
    end
    api.text layout: 'bombardment', range: index, str: bombardment_data do |embed|
      embed.svg layout: 'bombardment-icon', key: ':bombardment:', file: 'icons/bombardment.svg'
    end
  end

  def construction(api, construction_data, index)
    construction_data = construction_data.map do |construction|
      ":construction: #{construction}"
    end
    api.text layout: 'construction', range: index, str: construction_data do |embed|
      embed.svg layout: 'construction-icon', key: ':construction:', file: 'icons/construction.svg'
    end
  end
end
